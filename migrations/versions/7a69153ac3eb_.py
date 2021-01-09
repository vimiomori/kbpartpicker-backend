"""empty message

Revision ID: 7a69153ac3eb
Revises: d35411485e64
Create Date: 2021-01-06 18:42:32.922079

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = '7a69153ac3eb'
down_revision = 'd35411485e64'
branch_labels = None
depends_on = None


stabilizer_type = postgresql.ENUM('pcb_screw_in', 'pcb_snap_in', 'plate_mount', name='stabilizer_type')
layout_type = postgresql.ENUM('forty_percent', 'sixty_percent', 'sixtyfive_percent', 'seventyfive_percent', 'tenkeyless', 'winkeyless', 'hhkb', 'full_size', name='layout_type')
size_type = postgresql.ENUM('six_point_25_u', 'seven_u', 'two_u', name='size_type')
product_type = postgresql.ENUM('switch', 'case', 'pcb', 'plate', 'keyset', name='product_type')
stabilizer_type.create(op.get_bind())
layout_type.create(op.get_bind())
size_type.create(op.get_bind())
product_type.create(op.get_bind())

def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('products', sa.Column('layout', layout_type, nullable=True))
    op.add_column('products', sa.Column('size', size_type, nullable=True))
    op.add_column('products', sa.Column('stabilizer_type', stabilizer_type, nullable=True))
    op.add_column('products', sa.Column('type', product_type, nullable=False))
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('products', 'type')
    op.drop_column('products', 'stabilizer_type')
    op.drop_column('products', 'size')
    op.drop_column('products', 'layout')
    # ### end Alembic commands ###
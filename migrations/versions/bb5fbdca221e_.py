"""empty message

Revision ID: bb5fbdca221e
Revises: fb5b6ed61b8c
Create Date: 2021-01-07 13:51:34.493075

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = 'bb5fbdca221e'
down_revision = 'fb5b6ed61b8c'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('products', 'type')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('products', sa.Column('type', postgresql.ENUM('switch', 'case', 'pcb', 'plate', 'keyset', 'kit', 'stabilizer', 'lube', 'film', 'spring', 'tool', 'deskmat', name='product_type'), autoincrement=False, nullable=True))
    # ### end Alembic commands ###
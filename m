From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Fri, 20 Oct 2017 18:22:46 -0700
Subject: [GIT PULL 3/3] Keystone SOC update for 4.15
In-Reply-To: <1508548966-7350-1-git-send-email-santosh.shilimkar@oracle.com>
References: <1508548966-7350-1-git-send-email-santosh.shilimkar@oracle.com>
Message-ID: <1508548966-7350-3-git-send-email-santosh.shilimkar@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e19b205be43d11bff638cad4487008c48d21c103:

  Linux 4.14-rc2 (2017-09-24 16:38:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_soc_drivers_4.15

for you to fetch changes up to 595f3a9de5815d38198136491fa50a8ee1700b7d:

  ti_sci: Use %pS printk format for direct addresses (2017-10-09 09:54:14 -0700)

----------------------------------------------------------------
Keystone SOC for 4.15

----------------------------------------------------------------
Helge Deller (1):
      ti_sci: Use %pS printk format for direct addresses

 drivers/firmware/ti_sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

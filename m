From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 20 May 2013 16:19:59 -0400
Subject: [GIT PULL 1/2] of/pci dependency for mvebu/arm-soc
Message-ID: <20130520201959.GN31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/of_pci-3.11

for you to fetch changes up to 4e23d3f505e8acfeac7cc33d4113fbb5a25c3090:

  of/pci: Add of_pci_parse_bus_range() function (2013-05-19 20:30:10 +0000)

----------------------------------------------------------------
of/pci changes for v3.11

 - parse DT ranges property
 - add of_pci_get_devfn()
 - add of_pci_parse_bus_range()

Note:
 - mvebu/pcie will depend on this branch
 - work by LinusW and possibly Arnd will depend on this branch

----------------------------------------------------------------
Andrew Murray (1):
      of/pci: Provide support for parsing PCI DT ranges property

Thierry Reding (2):
      of/pci: Add of_pci_get_devfn() function
      of/pci: Add of_pci_parse_bus_range() function

 drivers/of/address.c       | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/of/of_pci.c        | 59 ++++++++++++++++++++++++++++++++++++----
 include/linux/of_address.h | 48 +++++++++++++++++++++++++++++++++
 include/linux/of_pci.h     |  2 ++
 4 files changed, 171 insertions(+), 5 deletions(-)

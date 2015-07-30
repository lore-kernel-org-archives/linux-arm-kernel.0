From: mohun106@gmail.com (Radha Mohan)
Date: Wed, 29 Jul 2015 17:01:06 -0700
Subject: [PATCH v2 0/3] Add MDIO support to ThunderX NIC driver
In-Reply-To: <1438121533-21528-1-git-send-email-mohun106@gmail.com>
References: <1438121533-21528-1-git-send-email-mohun106@gmail.com>
Message-ID: <CAC8NTUXy0Man6QvxgRJW-B4KPxrrzK5ngDAAZX8PB5nPwBKYVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 3:12 PM,  <mohun106@gmail.com> wrote:
> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
>
> This patch series adds MDIO support to ThunderX NIC driver by making use
> of existing mdio-octeon driver. In the process modified the mdio-octeon
> driver to work on both Octeon and ThunderX platforms.
>
> * From v1:
>   - Removed default selection in Kconfig for MDIO_OCTEON
>   - Replace uint64 with u64 as suggested by David Daney
>
> Radha Mohan Chintakuntla (3):
>   net: mdio-octeon: Modify driver to work on both ThunderX and Octeon
>   net: mdio-octeon: Fix octeon_mdiobus_probe function for return values
>   net: thunderx: Select CONFIG_MDIO_OCTEON for ThunderX NIC
>
>  drivers/net/ethernet/cavium/Kconfig |    2 +
>  drivers/net/phy/Kconfig             |   10 ++--
>  drivers/net/phy/mdio-octeon.c       |  136 +++++++++++++++++++++++++++++------
>  3 files changed, 122 insertions(+), 26 deletions(-)
>

Cc'ing David Miller.
Can you pick this patch series please ?

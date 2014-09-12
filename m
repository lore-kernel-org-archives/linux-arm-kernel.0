From: fishgolf@gmail.com (Patrick Boyle)
Date: Thu, 11 Sep 2014 22:40:29 -0400
Subject: Q about driver code for KSZ8873MML
Message-ID: <CAH=J7GMQMGhEgiGQiXru1P4zdZjemFwwWrUjhRWBN+jS-qsF=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the linux/include/micrel_phy.h file the PHY ID for the KSZ8873MML
is defined as (0x000e7237)

#define MICREL_PHY_ID_MASK     0x00fffff0

#define PHY_ID_KSZ8873MLL      0x000e7237
#define PHY_ID_KSZ9021         0x00221610
#define PHY_ID_KSZ8737         0x00221720
/* same id: KS8021, KS8031 */
#define PHY_ID_KSZ8021         0x00221555
#define PHY_ID_KSZ8041         0x00221510
#define PHY_ID_KSZ8051         0x00221550
/* same id: ks8001 Rev. A/B, and ks8721 Rev 3. */
#define PHY_ID_KSZ8001         0x0022161A
/* same id: KS8081, KS8091 */
#define PHY_ID_KSZ8081         0x00221560
#define PHY_ID_KSZ8061         0x00221570
#define PHY_ID_KSZ9031         0x00221620

/* struct phy_device dev_flags definitions */
#define MICREL_PHY_50MHZ_CLK   0x00000001

But the datasheet from Micrel for this part (and using mii to probe
the part on my board) shows:

0x00221430

So where did 0x000e7237 come from?

Thanks
Patrick Boyle

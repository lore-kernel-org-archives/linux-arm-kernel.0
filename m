From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Apr 2016 08:22:42 -0300
Subject: [PATCH v2] ARM: dts: imx6: Add dts for Embest MarS Board
In-Reply-To: <570EB2DB.20707@e-labworks.com>
References: <1460420743-30883-1-git-send-email-sergio.prado@e-labworks.com>
 <CAOMZO5D80VWGad7Lz+Crp8on5xLJzHDXL88FBh7x8d4Mc2XKww@mail.gmail.com>
 <570EB2DB.20707@e-labworks.com>
Message-ID: <CAOMZO5DwOa8s_tBJWpOjcxt0hj6befxjPFwVH57SOO5J5Hm5fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergio,

On Wed, Apr 13, 2016 at 5:58 PM, Sergio Prado
<sergio.prado@e-labworks.com> wrote:

> Although the boards are similar, there are a lot of differences:
>
> Marsboard -> imx6dual, no sound, sst25vf016b spi flash, 1 external sd/mmc
> interface (sdhc2) and one eMMC (sdhc3), different PMUX config for no sdhc3,
> no pmic, i2c1, i2c2 and i2c3 externally available, no ssi interface.
>
> Riotboard -> imx6solo, sound (sgtl5000), no spi flash, 2 external sd/mmc
> interface (sdhc2 and sdhc3) and one eMMC (sdhc4), pmic (pfuze100), i2c1,
> i2c2 and i2c4 externally available, ssi interface.
>
> We could certainly create a dtsi file to be shared between them, but I do
> not know if it is worth the effort.
>
> What do you think?

Ok, it seems it is not worth to share a device tree between them.

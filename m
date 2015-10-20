From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Oct 2015 09:26:09 -0700
Subject: [PATCH 0/3] ARM: dts: Use IOPAD pinmux for IGEP boards
In-Reply-To: <1445268861-11857-1-git-send-email-javier@osg.samsung.com>
References: <1445268861-11857-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20151020162608.GI3078@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier@osg.samsung.com> [151019 08:39]:
> Hello,
> 
> This series use the IOPAD pinmux macros for the remaining IGEP boards that
> still used the register offset instead of the physical address using these
> macros so the DTS matches what is in the Technical Reference Manual.
> 
> The changes are only cosmetic since they make the DTS easier to read but
> does not change functionality. I built tested and compared the binary DTB
> MD5 checksum and both matches before and after the series applied:
> 
> Before
> 
> d7a56205bdc54365d49d9a90dfe3fafb  am335x-base0033.dtb
> fa272fcdee65d7bf4c03bd5a6c5ec4fd  omap3-igep0020.dtb
> ba65bf74d8c6ea8e7bd8face17179e6e  omap3-igep0020-rev-f.dtb
> 
> After
> 
> d7a56205bdc54365d49d9a90dfe3fafb  am335x-base0033.dtb
> fa272fcdee65d7bf4c03bd5a6c5ec4fd  omap3-igep0020.dtb
> ba65bf74d8c6ea8e7bd8face17179e6e  omap3-igep0020-rev-f.dtb

Good idea to test the dtb checksums :)

Applying all into omap-for-v4.4/dt thanks.

Tony

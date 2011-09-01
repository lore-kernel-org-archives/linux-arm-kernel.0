From: axel.lin@gmail.com (Axel Lin)
Date: Fri, 2 Sep 2011 07:40:12 +0800
Subject: [PATCH] ARM: mach-davinci: Select PHYLIB for ARCH_DAVINCI_DM644x
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930257268D10@dbde02.ent.ti.com>
References: <1313903348.25059.3.camel@phoenix>
	<B85A65D85D7EB246BE421B3FB0FBB5930257268D10@dbde02.ent.ti.com>
Message-ID: <CAF+7xWm3TBBvWbqvsCiP3_yLykZxW0sW1Q454KJGVLDmkr8Rbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/2 Nori, Sekhar <nsekhar@ti.com>:
> Hi Axel,
>
> On Sun, Aug 21, 2011 at 10:39:08, Axel Lin wrote:
>> We call phy_register_fixup_for_uid in davinci_evm_init, thus we need
>> select PHYLIB to fix below build error: (with "make davinci_all_defconfig")
>
> This shouldn't happen with davinci_all_defconfig as it
> selects PHYLIB (this doesn't undermine the need for a fix).

I remember that I got the build error with davinci_all_defconfig, but
the build seems ok now with linux-next ( next-20110831 ).

Regards,
Axel

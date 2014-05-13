From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 13 May 2014 14:26:33 +0900
Subject: [PATCH] ARM: dts: Remove vmmc-supply for mmc@12220000 on
 arndale-octa board
In-Reply-To: <20140428105511.GA17293@e102654-lin.cambridge.arm.com>
References: <1398456672-3936-1-git-send-email-javi.merino@arm.com>
 <535AC29E.8010905@gmail.com>
 <20140425203051.GD3027@e102654-lin.cambridge.arm.com>
 <535AC717.40805@gmail.com>
 <20140425204135.GF3027@e102654-lin.cambridge.arm.com>
 <0b5c01cf6141$687f5ea0$397e1be0$@samsung.com>
 <CAK9yfHz5bkyTUr3Y=q8msuY_ciAjv5=n7dtf7DhTwgDxntOMNQ@mail.gmail.com>
 <20140428105511.GA17293@e102654-lin.cambridge.arm.com>
Message-ID: <073701cf6e6b$e7407170$b5c15450$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javi Merino wrote:
> 
> Hi Sachin,

Hi Sachin and Javi,

[...]

> >
> > You need the following patch to mount the MMC. Without this the
> regulator will
> > not be enabled which is required by MMC.
> >
> > ARM: exynos_defconfig: Enable HS-I2C
> > http://permalink.gmane.org/gmane.linux.kernel.samsung-soc/27527
> 
> Yes, that's the bit that I was missing.  With that patch 3.15-rc2
> boots on my Arndale Octa.
> 
> > Kukjin, can you please apply this patch?
> 
> You can add my Tested-by for Arndale Octa.
> 
OK, agreed. I will apply the enable HS-I2C on exynos_defconfig with Javi's test tag.

Thanks,
Kukjin

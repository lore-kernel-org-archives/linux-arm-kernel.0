From: b32955@freescale.com (Huang Shijie)
Date: Wed, 4 Sep 2013 18:29:34 +0800
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130904095523.GT3084@sirena.org.uk>
References: <1377828449-18912-1-git-send-email-b32955@freescale.com>
 <522697E9.1050208@freescale.com> <20130904095523.GT3084@sirena.org.uk>
Message-ID: <52270B8E.5080402@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?09?04? 17:55, Mark Brown ??:
> On Wed, Sep 04, 2013 at 10:16:09AM +0800, Huang Shijie wrote:
>
>> Since this quadspi driver depends on the mtd code, could this driver
>> goes to the kernel by
>> the l2-mtd tree?
> Why would a SPI driver depend on MTD?
The patch 1-4 are for m25p80.c, and this quadspi controller drivers
depends on the
patch 1-4.



thanks
Huang Shijie

From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sun, 03 Apr 2011 17:50:57 +0530
Subject: [PATCH 6/6] ARM: gic: use handle_fasteoi_irq for SPIs
In-Reply-To: <1301833138.5022.6.camel@jazzbox>
References: <1301669441-13744-1-git-send-email-will.deacon@arm.com>	<1301669441-13744-7-git-send-email-will.deacon@arm.com>	<BANLkTi=xeCaF4HwOsEnqCzkiywPu6R0XbA@mail.gmail.com>	<BANLkTimJwCkabdEhQ89NgEaWyYaX6kSgUQ@mail.gmail.com>	<4D980E77.10907@ti.com>
	<1301833138.5022.6.camel@jazzbox>
Message-ID: <4D986629.1050706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/3/2011 5:48 PM, Will Deacon wrote:
> On Sun, 2011-04-03 at 07:06 +0100, Santosh Shilimkar wrote:
>> Will,
>
> Hi Santosh,
>
>> Have already tested your V3 vesrion while generating the GIC
>> IO_relaxed patch and it worked OK. This series seems to be same.
>> I shall try this on OMAP4 and let you know ?
>
> If you hold your horses then I'll post a newer series addressing the
> points from Colin. Testing that on OMAP4 would be much appreciated!
>
Sure.

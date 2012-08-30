From: b29396@freescale.com (Dong Aisheng)
Date: Thu, 30 Aug 2012 16:12:16 +0800
Subject: MX28 & finding out boot mode
In-Reply-To: <20120830082518.GA27306@pengutronix.de>
References: <20120830082518.GA27306@pengutronix.de>
Message-ID: <20120830081215.GA1198@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 04:25:18PM +0800, Wolfram Sang wrote:
> Hi,
> 
> is there a way to find out how the MX28 was booted? I could read out the
> bootmode-pins for indication. Still, either by button or by empty NAND,
> the CPU could have been booted via USB recovery mode. And going through
> the docs and the bootlets code, I can't find a way to determine if USB
> recovery was used.
> 
> So, can USB recovery mode be detected somehow? Then, this and reading
> pins should be sufficent, no?
> 
Add Frank&Peter who may know it.

Regards
Dong Aisheng

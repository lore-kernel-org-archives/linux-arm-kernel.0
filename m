From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Feb 2012 22:53:29 +0000
Subject: [PATCH 1/4] ARM: sa1100: fix sa1100 after sparse irq conversion
In-Reply-To: <20120223222538.GB15494@n2100.arm.linux.org.uk>
References: <1329449534-23811-1-git-send-email-robherring2@gmail.com>
 <1329449534-23811-2-git-send-email-robherring2@gmail.com>
 <20120223221144.GA15494@n2100.arm.linux.org.uk> <4F46BC87.2030503@gmail.com>
 <20120223222538.GB15494@n2100.arm.linux.org.uk>
Message-ID: <20120223225329.GC15494@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 10:25:38PM +0000, Russell King - ARM Linux wrote:
> Probably best to just drop the change to this driver - it needs fixing
> properly at some point.  In the mean time, enabling both pleb and neponset
> will cause grief... ;(

In case I wasn't clear, a replacement patch for 7342/1 without the smsc
change please.

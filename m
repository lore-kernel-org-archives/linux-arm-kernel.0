From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 14 Aug 2013 14:22:54 -0400 (EDT)
Subject: [PATCHv3 3/5] arm64: read enable-method for CPU0
In-Reply-To: <520BC95B.6080307@ti.com>
References: <1376497228-20543-1-git-send-email-mark.rutland@arm.com>
 <1376497228-20543-4-git-send-email-mark.rutland@arm.com>
 <520BC95B.6080307@ti.com>
Message-ID: <alpine.LFD.2.03.1308141421560.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Aug 2013, Santosh Shilimkar wrote:

> On Wednesday 14 August 2013 12:20 PM, Mark Rutland wrote:
> > With the advent of CPU_HOTPLUG, the enable-method property for CPU0
> > may tells us something useful (i.e. how to hotplug it back on), so
> > we must read it along with all the enable-method for all the other CPUs.
> >
> Can you please expand this a bit.
> 
> > This patch ensures that CPU0's enable-method property is read.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > ---
> Am just wondering how this is useful for the boot CPU.

"Sane" systems allow the boot CPU to be hotplugged out like the others.


Nicolas

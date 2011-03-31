From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 31 Mar 2011 11:09:21 +0800
Subject: /proc/cpu/clocks
In-Reply-To: <AANLkTik6NQvgT1sdFf7Vg-nXCM1PKv43WhqnzOJuR=cV@mail.gmail.com>
References: <AANLkTikBgq0bSRSQRSzeu==ByemegSB+x7AXXeJjR_ct@mail.gmail.com>
	<20110330191938.GE2939@n2100.arm.linux.org.uk>
	<AANLkTik6NQvgT1sdFf7Vg-nXCM1PKv43WhqnzOJuR=cV@mail.gmail.com>
Message-ID: <20110331030920.GA3523@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matt,

On Wed, Mar 30, 2011 at 04:06:45PM -0500, Matt Sealey wrote:
> Ah okay. So we get to bug Freescale :)
The clock debug info is what I'm looking for too.
Freescale kernel does have the clock debug info. But mainline kernel does not.
The common clock code does not have the concept of "parent".

Thanks
Richard
> 
> -- 
> Matt Sealey <matt@genesi-usa.com>
> Product Development Analyst, Genesi USA, Inc.
> 
> 
> 
> On Wed, Mar 30, 2011 at 2:19 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Mar 30, 2011 at 11:27:46AM -0500, Matt Sealey wrote:
> >> Where did /proc/cpu/clocks go in the kernel and where can I find the
> >> equivalent information?
> >
> > It has never existed as a generic thing in mainline. ?If some platform
> > added it then it was private to that platform.
> >
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

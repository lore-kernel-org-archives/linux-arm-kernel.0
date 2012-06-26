From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Jun 2012 18:16:33 +0100
Subject: try_to_freeze() called with IRQs disabled on ARM
In-Reply-To: <CACBanvqp52q0c6SxsSFqZwfn45Knt-CYgg-AcOJrtaQ-Lim+YQ@mail.gmail.com>
References: <20110823221314.GL3895@n2100.arm.linux.org.uk>
 <CAOS58YNtQEuke=Ko9J2oNGMECjabzxj=Nrg1o64X1JC3YRmJuw@mail.gmail.com>
 <20110825121416.GB8883@n2100.arm.linux.org.uk>
 <20110825121710.GK3286@htj.dyndns.org>
 <20110825122543.GC8883@n2100.arm.linux.org.uk>
 <20110825123542.GM3286@htj.dyndns.org>
 <20110825130414.GE8883@n2100.arm.linux.org.uk>
 <20110825130907.GO3286@htj.dyndns.org>
 <20110825145558.GF8883@n2100.arm.linux.org.uk>
 <CACBanvqp52q0c6SxsSFqZwfn45Knt-CYgg-AcOJrtaQ-Lim+YQ@mail.gmail.com>
Message-ID: <20120626171632.GA22977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 09:39:14AM -0700, Mandeep Singh Baines wrote:
> Hi Russell,
> 
> We are seeing this on ARM with a 3.4 kernel. How was it eventually
> resolved? This patch isn't in any tree and I can't find any patch in
> linus/master or in any ARM tree that looks like it fixes this.

It's still work in progress.

From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 20:39:41 +0200
Subject: [PATCH 0/3] ARM: implement workaround for Cortex-A9/PL310/PCIe
 deadlock
In-Reply-To: <20140414165956.GJ12916@arm.com>
References: <1395677872-32741-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140403160727.17b3558b@skate>
 <20140403141533.GP7528@n2100.arm.linux.org.uk>
 <20140407121304.GD3360@arm.com> <20140414165956.GJ12916@arm.com>
Message-ID: <20140414203941.4924e277@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Will Deacon,

On Mon, 14 Apr 2014 17:59:56 +0100, Will Deacon wrote:

> > > Will is away for another week and a half.
> > 
> > And when he's back, I'm pretty sure he will be eager to look at the
> > PL310 code ;)
> 
> Lucky for me, it looks like rmk is rewriting it ;)
> 
> Is there anything you want me to do here?

Yes. I would actually been interested in a summary/conclusion of the
discussions, because I'm not sure what I'm supposed to do now. So there
are two parts here:

 * Mapping PCIe I/O regions as strongly ordered.

 * Disabling outer_cache sync in the PL310 driver.

Some discussion has been going on with Catalin, I've answered some
questions by providing more details to Catalin, but in the end, I don't
know if the patches I provided are acceptable or not, and if not, in
what way they should be changed.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

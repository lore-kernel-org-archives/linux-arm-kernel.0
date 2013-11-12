From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 12 Nov 2013 09:31:44 +0100 (CET)
Subject: [PATCH 0/2] genirq: arm64: perf: support for percpu pmu interrupt
In-Reply-To: <CAPrCYkf60+9RJ2aJ5ep3-j+ThdniJQHnUj_8POrCr7X2veKRZQ@mail.gmail.com>
References: <1383739658-10036-1-git-send-email-vkale@apm.com>
 <527D8A17.9020208@codeaurora.org>
 <20131111104432.GA28302@mudshark.cambridge.arm.com>
 <CAPrCYkf60+9RJ2aJ5ep3-j+ThdniJQHnUj_8POrCr7X2veKRZQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1311120924390.30673@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Nov 2013, Vinayak Kale wrote:
> On Mon, Nov 11, 2013 at 4:14 PM, Will Deacon <will.deacon@arm.com> wrote:
> > cleaner from a user perspective, I always get scared when I see
> > 'desc->status_use_accessors' since it tends to incur the wrath of tglx :)

Nah, if it uses accessors, then it's fine.

> > That said, I guess that should be fine in irqdesc.h (basically adding a new
> > accessor). Chris went missing after sending those initial patches, so
> > perhaps Vinayak could look at resurrecting those?
> >
> Okay, in next patch revision I will use that approach.

Works for me.

Thanks,

	tglx
 

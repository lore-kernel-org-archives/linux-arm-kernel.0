From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Jan 2012 09:52:57 +0000
Subject: [PATCH] ARM: gic: refactor irq_start assignment
In-Reply-To: <20120118213223.GQ4223@ponder.secretlab.ca>
References: <1326802195-11412-1-git-send-email-will.deacon@arm.com>
 <4F159B81.9080104@gmail.com>
 <20120117160334.GD27350@mudshark.cambridge.arm.com>
 <20120118213223.GQ4223@ponder.secretlab.ca>
Message-ID: <20120119095256.GA1701@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 09:32:23PM +0000, Grant Likely wrote:
> On Tue, Jan 17, 2012 at 04:03:34PM +0000, Will Deacon wrote:
> > On Tue, Jan 17, 2012 at 04:02:09PM +0000, Rob Herring wrote:
> > > 
> > > This should probably just be rolled into Grant's irqdomain work. In any
> > > case, it's going to conflict with it.
> > 
> > Ok, it's purely cosmetic so I'm fine with that. Grant - would you be able to
> > pick this up please?
> 
> The conflict is pretty trivial and I'll handle any fixups if a
> conflict occurs.  I'd rather not have changes unrelated to the
> conversion in my series.

Okey doke then, I'll stick to the original plan (via Russell's patch system) :)

Thanks,

Will

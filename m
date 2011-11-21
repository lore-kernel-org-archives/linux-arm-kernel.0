From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Nov 2011 15:16:12 +0000
Subject: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
In-Reply-To: <CACVXFVMzmjzi=3YxSG8EP+eb=8pe9Oo50MBmn+_cdkaVJkyGdA@mail.gmail.com>
References: <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
 <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
 <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
 <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
 <4EC6566C.70202@ti.com>
 <20111118145635.GB17991@mudshark.cambridge.arm.com>
 <CACVXFVNuz62+2DzOks3-0io2Ni=LK5SJienU4GcGRMtkh92vvQ@mail.gmail.com>
 <alpine.DEB.2.00.1111192019200.30133@utopia.booyaka.com>
 <20111121135828.GC20611@mudshark.cambridge.arm.com>
 <CACVXFVMzmjzi=3YxSG8EP+eb=8pe9Oo50MBmn+_cdkaVJkyGdA@mail.gmail.com>
Message-ID: <20111121151612.GF20611@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 02:53:54PM +0000, Ming Lei wrote:
> On Mon, Nov 21, 2011 at 9:58 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Sun, Nov 20, 2011 at 03:27:19AM +0000, Paul Walmsley wrote:
> >> The OMAP-specific parts should be queued up in my/Beno?t's/Tony's trees,
> >> rather than placed directly into -next. ?Otherwise they are likely to
> >> generate merge conflicts with other OMAP changes that we may generate.
> >>
> >> So I'd suggest splitting patches 1-3 off into a separate series that Will
> >> can pass on to -next if he wishes.
> >
> > Fine by me. If Ming Lei posts a new series so that everything is in one
> > thread then I can pick out the bits I want.
> 
> You mean the 3rd patch is the debugss patch posted by Benoit?
> The original 3rd patch is not needed any more once the debugss patch
> is taken.

Ah sorry, I lost track a bit. In that case, I'll just keep hold of the two
patches I have and deal with them appropriately.

Will

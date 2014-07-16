From: zlim.lnx@gmail.com (Zi Shen Lim)
Date: Wed, 16 Jul 2014 15:18:23 -0700
Subject: [PATCH RFCv3 00/14] arm64: eBPF JIT compiler
In-Reply-To: <20140716162146.GV29414@arm.com>
References: <1405405512-4423-1-git-send-email-zlim.lnx@gmail.com>
 <20140716104153.GL29414@arm.com> <20140716162146.GV29414@arm.com>
Message-ID: <20140716221823.GA3378@gup76>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 05:21:47PM +0100, Will Deacon wrote:
> On Wed, Jul 16, 2014 at 11:41:53AM +0100, Will Deacon wrote:
> > On Tue, Jul 15, 2014 at 07:24:58AM +0100, Zi Shen Lim wrote:
> > > This series implements eBPF JIT compiler for arm64.
> > > See [14/14] for change log.
> > > 
> > > Patches [1-13/14] implement code generation functions.
> > 
> > Nice work, I'll take a look. Thanks!
> 
> ... and it all looks pretty damn good to me. I gave you a few in-line

Thanks :)

> comments but, rather than repeat myself for each patch, my main two gripes
> were:
> 
>   - The use of BUG_ON all over the place

I responded to your comment about BUG_ON in [1/14].

> 
>   - Explicit limit checks which could be done with masks

I responded to your comment about this in [8/14]. I can go ahead and
make changes throughout if you prefer.

> 
> If you address those, this stuff looks pretty much ready to go from my
> perspective. Do you have a branch somewhere I can play with please?

Just pushed it to:

	https://github.com/zlim/linux.git arm64/bpf

which is the same as this RFCv3 series, i.e. I haven't rebased it on
latest net-next.

Thanks so much for your time and attention!
Let me know how it goes for you.

I can post this series (dropping RFC) once we finalized the above.

Cheers,
z

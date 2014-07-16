From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Jul 2014 17:21:47 +0100
Subject: [PATCH RFCv3 00/14] arm64: eBPF JIT compiler
In-Reply-To: <20140716104153.GL29414@arm.com>
References: <1405405512-4423-1-git-send-email-zlim.lnx@gmail.com>
 <20140716104153.GL29414@arm.com>
Message-ID: <20140716162146.GV29414@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 11:41:53AM +0100, Will Deacon wrote:
> On Tue, Jul 15, 2014 at 07:24:58AM +0100, Zi Shen Lim wrote:
> > This series implements eBPF JIT compiler for arm64.
> > See [14/14] for change log.
> > 
> > Patches [1-13/14] implement code generation functions.
> 
> Nice work, I'll take a look. Thanks!

... and it all looks pretty damn good to me. I gave you a few in-line
comments but, rather than repeat myself for each patch, my main two gripes
were:

  - The use of BUG_ON all over the place

  - Explicit limit checks which could be done with masks

If you address those, this stuff looks pretty much ready to go from my
perspective. Do you have a branch somewhere I can play with please?

Cheers,

Will

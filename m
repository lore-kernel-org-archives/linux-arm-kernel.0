From: olof@lixom.net (Olof Johansson)
Date: Tue, 4 Sep 2012 22:16:56 -0700
Subject: [GIT PULL] ARM perf updates for 3.7
In-Reply-To: <20120829211034.GA13222@mudshark.cambridge.arm.com>
References: <20120829211034.GA13222@mudshark.cambridge.arm.com>
Message-ID: <20120905051656.GF6747@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 10:10:34PM +0100, Will Deacon wrote:
> Hi Arnd, Olof,
> 
> I appreciate that perf changes don't usually go via arm-soc, but in this
> case I'm touching a bunch of platforms (albeit in a fairly mechanical way)
> so it would be great if you could pull this into a branch for 3.7. Jon can
> then use it as a base for his OMAP PMU patches and I think that ST and
> Samsung may also have patches that depend on this lot.
> 
> The changes outside of platform code are restricted to perf files and the
> whole series has been in -next since -rc1.
> 
> Cheers,
> 
> Will
> 
> ---
> 
> The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:
> 
>   Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-perf-3.7

Seems reasonable. Pulled in as pmu/cleanup in next/cleanup.

Russell, protest if you want this through your tree instead, but since
it's a prereq for some of the other work we'll need to pull it in in
some form or other anyway.


-Olof

From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 24 Nov 2010 17:08:34 +0900
Subject: [patch v4 0/2] ARM: mach-shmobile: Add zboot support for SuperH
	Mobile ARM
In-Reply-To: <20101122231514.766413220@vergenet.net>
References: <20101122231514.766413220@vergenet.net>
Message-ID: <AANLkTin7BdyK-6c-ciC-hW+BRMdK8adAMPxV=s=frhKx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tue, Nov 23, 2010 at 8:15 AM, Simon Horman <horms@verge.net.au> wrote:
> this short patch series by Kuninori Morimoto and myself adds
> zboot support to mach-shmobile.
>
> This is v4 of the patch series, which includes
> a minor rediff to apply cleanly against linux-2.6-arm/devel
> without any fuzz.
>
> v2 implemented Magnus's suggestion to initialising atags directly rather
> than using assembly.
>
> v2 implemented Magnus's suggestion of setting atags in the framework and
> passing them to the kernel rather than using a board-specific fixup.

I think V4 of this series looks good, thanks for your work on this!

Acked-by: Magnus Damm <damm@opensource.se>

I'd like to see this merged upstream.

Russell, is there anything I can do to make merging of this series easier?

Thanks,

/ magnus

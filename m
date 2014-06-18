From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Jun 2014 18:44:19 +0100
Subject: [PATCH 0/2] arm64 bootwrapper fixes
In-Reply-To: <cover.1402531738.git.geoff@infradead.org>
References: <cover.1402531738.git.geoff@infradead.org>
Message-ID: <20140618174419.GB9612@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Thu, Jun 12, 2014 at 01:12:56AM +0100, Geoff Levand wrote:
> Hi Catalin,
> 
> Here are two fixes for the arm64 bootwrapper.  The first is a critical makefile
> fix, the second a minor configure fix.  Please consider.

Thanks for putting these together, it's much appreciated.

With Catalin's blessing I've taken over bootwrapper maintenance, so I've
taken these into my tree [1] with some slight changes to the second
patch to fit in with the existing naming scheme.

Cheers,
Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/boot-wrapper-aarch64.git

> 
> -Geoff
> 
> 
> The following changes since commit 09d7031d5642ff1d81c0dede9b86822d67b6b52a:
> 
>   boot-wrapper: arm64: add support for GICv3 (2014-05-09 18:43:52 +0100)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/geoff.levand/boot-wrapper-aarch64.git master
> 
> for you to fetch changes up to 8ad2293111bbd60ddecd071be34734c2b46415df:
> 
>   configure: Fixes for --enable-xxx (2014-06-11 17:07:54 -0700)
> 
> ----------------------------------------------------------------
> Geoff Levand (2):
>       Makefile: Add local perl module include path
>       configure: Fixes for --enable-xxx
> 
>  Makefile.am  | 14 +++++++-------
>  configure.ac | 19 +++++++++----------
>  2 files changed, 16 insertions(+), 17 deletions(-)
> 
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

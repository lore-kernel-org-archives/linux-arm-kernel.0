From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Jul 2014 09:36:05 -0700
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC r8a7779
 Multiplatform Updates for v3.17
In-Reply-To: <cover.1404173506.git.horms+renesas@verge.net.au>
References: <cover.1404173506.git.horms+renesas@verge.net.au>
Message-ID: <20140712163605.GC3954@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 09:28:28AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Second Round of Renesas ARM Based SoC r8a7779
> Multiplatform Updates for v3.17o.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-r8a7779-multiplatform-for-v3.17,
> which I have already sent a pull-request for.
> 
> I have applied this clean-up change to a non-cleanup branch
> to avoid adding conflicts that were known (to me) at the
> time of queuing up this change.
> 
> 
> The following changes since commit c1a0f9932b66b2298163c31f8ac3f2844476e1c2:
> 
>   ARM: shmobile: marzen: Do not use workaround for scif devices (2014-06-17 19:56:37 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-r8a7779-multiplatform2-for-v3.17
> 
> for you to fetch changes up to 1b55353c9214788b0d0797a5fd4585af1557a12c:
> 
>   ARM: shmobile: Move r8a7779.h (2014-06-25 16:52:39 +0900)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM Based SoC r8a7779-multiplatform Updates for v3.17
> 
> * Move r8a7779.h out of mach directory.
>   This is part of a multi-stage effort to move headers
>   out of that directory.

Merged, thanks.

-Olof

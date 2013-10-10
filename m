From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 10 Oct 2013 15:19:00 -0700
Subject: [GIT PULL] Second round of Renesas ARM based SoC cleanups for
 v3.13
In-Reply-To: <cover.1381222967.git.horms+renesas@verge.net.au> (Simon Horman's
 message of "Tue, 8 Oct 2013 18:05:24 +0900")
References: <cover.1381222967.git.horms+renesas@verge.net.au>
Message-ID: <87d2ncojl7.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon Horman <horms+renesas@verge.net.au> writes:

> Hi Kevin, Olof and Arnd,
>
> please consider this Second round of Renesas ARM based SoC cleanups for v3.13.
> It is based on renesas-cleanup-for-v3.13 which you have previously pulled.
>
>
> The following changes since commit cde214a890f81797a5eee94fffc89c1de21ed991:
>
>   ARM: shmobile: r8a7790: Constify platform data and resources (2013-09-19 14:33:44 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup2-for-v3.13
>
> for you to fetch changes up to 27113d63daac0aacaa26b1fabfc23391de4284f4:
>
>   ARM: shmobile: lager: Constify platform data and resources (2013-09-30 16:33:17 +0900)
>
> ----------------------------------------------------------------
> Second round of Renesas ARM based SoC cleanups for v3.13
>
> * Constify platform data and resources in lager board code
> * Clean up registration of VIN and sh_eth in r8a7778 SoC and
>    bockw board code
> * Make r8a7778_register_hspi() static in r8a7778 SoC code

Pulled into next/cleanup.

Thanks,

Kevin

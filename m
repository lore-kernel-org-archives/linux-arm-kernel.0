From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 16:22:05 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.16
In-Reply-To: <cover.1512553442.git.horms+renesas@verge.net.au>
References: <cover.1512553442.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a25kicb5dQi-U5tH0WdAjAGK5_CL4YXbNTWPM39dqFzdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 6, 2017 at 11:21 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these Renesas ARM based SoC updates for v4.16.
>
>
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
>
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.16
>
> for you to fetch changes up to 90f0d2b344313a8a4c366ef60d0df33008d2be84:
>
>   soc: renesas: Identify R-Car M3-W ES1.1 (2017-11-27 11:40:57 +0100)
>
> ----------------------------------------------------------------
> Renesas ARM Based SoC Updates for v4.16
>
> * Identify R-Car M3-W ES1.1
>
>   Geert Uytterhoeven says "The Product Register of R-Car M3-W ES1.1
>   incorrectly identifies the SoC revision as ES2.0.  Add a workaround to
>   fix this."
>
>   It is my understanding that this is likely to be forwards-compatibile.
>\

Pulled into next/soc, thanks!

      Arnd

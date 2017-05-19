From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 May 2017 10:16:40 +0200
Subject: [GIT PULL] omap fixes for v4.12-rc cycle
In-Reply-To: <158788626256017699@unknownmsgid>
References: <158788626256017699@unknownmsgid>
Message-ID: <CAK8P3a0+C5VuYtuifk6SnAdXcfdDoFchQuD2efZtNf5kqPoGsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 5:59 PM, Tony Lindgren <tony@atomide.com> wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
>
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.12/fixes-v2-signed
>
> for you to fetch changes up to bca5238816939436d72ae6bab124c4b0641a3a99:
>
>   ARM: dts: dra7: Reduce cpu thermal shutdown temperature (2017-05-17 06:51:38 -0700)
>
> ----------------------------------------------------------------
> Fixes for omaps for v4.12-rc cycle most consisting of few minor dts fixes
> for various devices. Also included is a memory controller (GPMC) debug output
> fix as without that the shown bootloader configured GPMC bus width will
> be wrong and won't work for kernel timings:

I see Olof has merged it into the fixes branch.

      Arnd

From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 May 2012 16:29:20 -0700
Subject: [GIT PULL] Renesas ARM-based platforms: core SoC updates for v3.5
In-Reply-To: <201205122307.20590.rjw@sisk.pl>
References: <201205112101.59949.rjw@sisk.pl>
 <CAOesGMgFWM6K6969Oz6xGewrRekyrJA-ztGBADxsqnB1w=V2QA@mail.gmail.com>
 <201205122307.20590.rjw@sisk.pl>
Message-ID: <CAOesGMgF3oLD9=db9d3rcGKPFzQYvCfBgaYHZmy8LPW46t0Yeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 12, 2012 at 2:07 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3
>
> ? ?Linux 3.4-rc6
>
> with top-most commit c8241085e8606a14ef48e6d99556133c48aaddaf
>
> ? ?ARM: mach-shmobile: clock-r8a7740: use followparent_recalc on usb24s
>
> from the git repository at:
>
> ?git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git soc-core
>
> to receive updates of the Renesas ARM-based platforms core code for v3.5.
> Included are:
>
> ?* Shared delay calibration code update from Magnus Damm.
>
> ?* The addition of FSI DMAEngine support for the sh7372 SoC from Kuninori Morimoto.
>
> ?* Muliple updates of the r8a7740 SoC support code from Kuninori Morimoto.
>
> This is based on the Renesas DT updates that have been merged into arm-soc already
> and on the urgent fixes I've sent a separate pull request for.
>
> Thanks!

Rafael,

This looks good, thanks for splitting things up. I will pull it in a
little later today when I get a few minutes of quiet.

If you start using signed tags, feel free to add the above description
into there for our convenience. :-)

Also, the diffstat below includes the dependent branches. Feel free to
send only the delta, but either way works.


-Olof

From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2018 12:40:43 +0200
Subject: [GIT PULL] berlin dt64 changes for v4.20
In-Reply-To: <20180927162106.7a7e48f7@xhacker.debian>
References: <20180927162106.7a7e48f7@xhacker.debian>
Message-ID: <CAK8P3a3T=P1SS9DRSNEniBrOkKJhd__FoMGZZ_Kt6Xjd32NXGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 10:24 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
>
>
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
>
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jszhang/linux-berlin.git tags/berlin64-dt-for-v4.20
>
> for you to fetch changes up to 087682f5a75bec349cdcb34c29384a051587aa99:
>
>   arm64: dts: synaptics: add dtsi file for Synaptics AS370 SoC (2018-09-27 14:48:43 +0800)
>
> ----------------------------------------------------------------
> Berlin64 DT changes for v4.20
>
>  - move berlin binding documentation to syna.txt
>  - add binding for the AS370 SoC
>  - add dtsi file for Synaptics AS370 SoC

Pulled into next/dt, but I noticed that the tag description was different on
the signed tag compared to the one in the email. I left it with the
one-line version, since the bullet list you have here does not add
any information that is not already part of the one-line patch
descriptions below it.

It would be nice to get a real description of the series as a whole
in the signed tag instead, to explain what overall theme is. In
this case, a good text would explain what the 'AS370 SoC' is,
including its main features and when this is expected to hit the
market.

     Arnd

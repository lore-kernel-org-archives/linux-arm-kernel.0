From: olof@lixom.net (Olof Johansson)
Date: Tue, 28 Jul 2015 18:16:55 +0200
Subject: [PULL REQUEST] ARM: mediatek: dts updates for v4.3
In-Reply-To: <CABuKBeJxTrQQ0jUkjr22pJ5o=60Rw+7Z0qOkYefdS1tCMAeBrA@mail.gmail.com>
References: <CABuKBeJxTrQQ0jUkjr22pJ5o=60Rw+7Z0qOkYefdS1tCMAeBrA@mail.gmail.com>
Message-ID: <20150728161655.GB16690@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 02:08:02PM +0200, Matthias Brugger wrote:
> Hi all,
> 
> Please take the following changes into account.
> 
> Thanks,
> Matthias
> 
> ---
> 
> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/mbgg/linux-mediatek.git tags/v4.2-next-dts
> 
> for you to fetch changes up to 7d4938c14d239768a2e0bdd94457f405e6d35555:
> 
>   ARM: dts: mediatek: add mt6580 basic support (2015-07-18 00:22:42 +0200)
> 
> ----------------------------------------------------------------
> - ARM: dts: mediatek: add mt6580 basic support
> - Document: DT: Add bindings for mediatek MT6580 SoC Platform
> - ARM: dts: mediatek mt8135: Use real UART clocks
> - ARM: dts: mt8135-evbp1: Add PMIC support
> - ARM: dts: mt8135: Add pmic wrapper nodes
> - ARM: dts: mediatek: Enable clock support for Mediatek MT8135.

I see you sent the same pull request twice, one mentioned "for 4.2",
another "for 4.3", but the contents is the same.  I'm presuming you
typoed once and 4.3 is the actual target since these aren't fixes. So,
merged into next/arm64 for the 4.3 merge window.

Thanks,


-Olof

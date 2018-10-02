From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 2 Oct 2018 09:56:23 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Enable USB phys for UniPhier SoCs
In-Reply-To: <1538381421-9171-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1538381421-9171-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <CAK8P3a2iHvV-Xb=jMc7NOGrjagwBpr5fAFmUcVX-TWfM38==sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 1, 2018 at 10:10 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Enable the USB3 and USB2 phys implemented in UniPhier SoCs.
> These phys are necessary for dwc3 and ehci controllers driving
> the USB ports on Pro4 and PXs2 SoCs.
>
> Since the USB host drivers are already built-in, so only the phy
> driver are missing to allow booting with USB devices.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---

Applied to next/defconfig with context changes.

      Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 1 Oct 2018 17:52:41 +0200
Subject: [PATCH] arm64: defconfig: Enable USB phys for UniPhier SoCs
In-Reply-To: <1538381445-9222-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1538381445-9222-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <CAK8P3a3dq4qs4jTgUVFwxJ89DLhESjracb5qTswXcKWj7tJg2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 1, 2018 at 10:10 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Enable the USB3 and USB2 phys implemented in UniPhier SoCs.
> These phys are necessary for dwc3 and ehci controllers driving
> the USB ports on arm64 UniPhier SoCs.
>
> Since the USB host drivers are already built-in, so only the phy
> driver are missing to allow booting with USB devices.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Applied, with context changes, thanks,

       Arnd

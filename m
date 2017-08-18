From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Aug 2017 22:48:24 +0200
Subject: [GIT PULL 3/3] ZTE arm64 device tree changes for 4.14
In-Reply-To: <1503043549-13232-3-git-send-email-shawnguo@kernel.org>
References: <1503043549-13232-1-git-send-email-shawnguo@kernel.org>
 <1503043549-13232-3-git-send-email-shawnguo@kernel.org>
Message-ID: <CAK8P3a1gFXD_Zj+d61wRHisWOP+5m5Xy4tQ0apgN2oMQ7+SSuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 10:05 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
> ZTE arm64 device tree updates for 4.14:
>  - A clean up patch from Shawn Lin to remove the deprecated dwmmc
>    property 'num-slots' from ZX296718 device tree.
>  - Enable various devices for ZX296718 SoC support, VGA display, I2S
>    audio, pinctrl, GPIO, PWM and IRDEC.
>  - Update zx296718-evb support to use audio-graph-card for HDMI audio
>    and add I2S sound card.
>  - Add initial zx296718-pcbox board support with storage, audio,
>    display devices enabled.

Pulled into next/dt64, thanks!

         Arnd

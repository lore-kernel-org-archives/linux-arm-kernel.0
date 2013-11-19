From: fkan@apm.com (Feng Kan)
Date: Tue, 19 Nov 2013 14:01:09 -0800
Subject: [PATCH 0/4] Add missing components for X-Gene reboot drivers.
In-Reply-To: <1384294092-18794-1-git-send-email-fkan@apm.com>
References: <1384294092-18794-1-git-send-email-fkan@apm.com>
Message-ID: <CAL85gmDaV-d5xS8gM1RFEqCsa3ocaym+bjxhFueYiqtf-N4NBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any comments on this?

On Tue, Nov 12, 2013 at 2:08 PM, Feng Kan <fkan@apm.com> wrote:
> Add dts node for X-Gene reboot driver. Apply documentation dts binding.
> Some minor compile warning fix and enable reboot driver by default.
>
> Feng Kan (4):
>   Documentation: add dts binding for X-Gene reboot dts node.
>   arm64: add missing dts entry for X-Gene platform.
>   arm64: Enable system reset via arch Kconfig for X-Gene system.
>   arm64: removed using of the mask attribute in the dts for reset bit.
>
>  .../devicetree/bindings/arm64/xgene/reboot.txt     |   11 +++++++++++
>  arch/arm64/Kconfig                                 |    1 +
>  arch/arm64/boot/dts/apm-storm.dtsi                 |    5 +++++
>  drivers/power/reset/xgene-reboot.c                 |    5 ++---
>  4 files changed, 19 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm64/xgene/reboot.txt
>
> --
> 1.7.6.1
>

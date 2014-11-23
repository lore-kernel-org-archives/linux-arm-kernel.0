From: carlo@caione.org (Carlo Caione)
Date: Sun, 23 Nov 2014 12:48:31 +0100
Subject: [PATCH RESEND 0/3] ARM: Meson6: enable SMP
In-Reply-To: <1415982353-9293-1-git-send-email-carlo@caione.org>
References: <1415982353-9293-1-git-send-email-carlo@caione.org>
Message-ID: <CAOQ7t2amsAvD_O6XO_jF9NRhAAWrG+_URKNytmY-6aUE+wchnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 5:25 PM, Carlo Caione <carlo@caione.org> wrote:
> Amlogic Meson6 is a dual-core Cortex-A9. This patchset adds all the necessary
> pieces to boot the secondary CPU.
>
> ---
>
> This is a resend of a patchset already submitted a while ago
> http://www.spinics.net/lists/arm-kernel/msg366787.html
>
> Carlo Caione (3):
>   ARM: Meson6: docs: document bindings
>   ARM: Meson6: Add SMP support for Amlogic Meson6
>   ARM: Meson6: enable SMP in DTS/DTSI
>
>  .../bindings/arm/meson/amlogic,meson6-cpuconfig    | 16 +++++
>  .../bindings/arm/meson/amlogic,meson6-smp          | 26 +++++++
>  arch/arm/boot/dts/meson.dtsi                       |  5 ++
>  arch/arm/boot/dts/meson6.dtsi                      |  6 ++
>  arch/arm/mach-meson/Kconfig                        |  1 +
>  arch/arm/mach-meson/Makefile                       |  1 +
>  arch/arm/mach-meson/headsmp.S                      |  7 ++
>  arch/arm/mach-meson/platsmp.c                      | 80 ++++++++++++++++++++++
>  8 files changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/meson/amlogic,meson6-cpuconfig
>  create mode 100644 Documentation/devicetree/bindings/arm/meson/amlogic,meson6-smp
>  create mode 100644 arch/arm/mach-meson/headsmp.S
>  create mode 100644 arch/arm/mach-meson/platsmp.c

Ping


-- 
Carlo Caione

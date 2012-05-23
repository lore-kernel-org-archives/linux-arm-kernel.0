From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Wed, 23 May 2012 17:03:51 -0500
Subject: [PATCH 0/2] OMAP: mailbox initial device tree support
In-Reply-To: <1335894460-19941-1-git-send-email-omar.luna@linaro.org>
References: <1335894460-19941-1-git-send-email-omar.luna@linaro.org>
Message-ID: <CALLhW=7ENCpodLxf-vaY6EzYRv9uKz_52FDsUbMAaSGNFy4LiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony, Benoit,

On 1 May 2012 12:47, Omar Ramirez Luna <omar.luna@linaro.org> wrote:
> To allow mailbox driver to function with device tree.
>
> Tested in OMAP4 and OMAP3. OMAP2 untested.
>
> Omar Ramirez Luna (2):
> ?OMAP: mailbox: add device tree support
> ?arm/dts: OMAP2+: Add mailbox nodes
>
> ?.../devicetree/bindings/arm/omap/mailbox.txt ? ? ? | ? ?9 +++++++++
> ?arch/arm/boot/dts/omap2.dtsi ? ? ? ? ? ? ? ? ? ? ? | ? ?5 +++++
> ?arch/arm/boot/dts/omap3.dtsi ? ? ? ? ? ? ? ? ? ? ? | ? ?5 +++++
> ?arch/arm/boot/dts/omap4.dtsi ? ? ? ? ? ? ? ? ? ? ? | ? ?5 +++++
> ?arch/arm/mach-omap2/devices.c ? ? ? ? ? ? ? ? ? ? ?| ? ?3 +++
> ?arch/arm/mach-omap2/mailbox.c ? ? ? ? ? ? ? ? ? ? ?| ? 12 ++++++++++++
> ?6 files changed, 39 insertions(+), 0 deletions(-)
> ?create mode 100644 Documentation/devicetree/bindings/arm/omap/mailbox.txt

Can you share your thoughts for these patches?

Regards,

Omar

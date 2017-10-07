From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 7 Oct 2017 12:48:31 +0200
Subject: [PATCH v3 00/12] add pinmuxing support for pins in AXP209 and
 AXP813 PMICs
In-Reply-To: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
Message-ID: <CACRpkdYBfuyr8hzVTH_RFfM4uYOMbWTHnH9SeF8SMGFe-shEWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 2, 2017 at 2:08 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:

> The AXP209 and AXP813 PMICs have several pins (respectively 3 and 2) that can
> be used either as GPIOs or for other purposes (ADC or LDO here).
>
> We already have a GPIO driver for the GPIO use of those pins on the AXP209.
> Let's "upgrade" this driver to support all the functions these pins can have.
>
> Then we add support to this driver for the AXP813 which is slighlty different
> (basically a different offset in a register and one less pin).
>
> I suggest patches 1 to 6 go through Linus's tree and 7 to 12 via Maxime or
> Chen-Yu's tree.
>
> This version of the patchset is based on Chen-Yu's patchset for AXP813/818
> regulators[1].
>
> v3:

This is starting to look really good, but I see there are still comments.

Keep the series going, we merge once Maxime and Chen-Yu are happy.

Yours,
Linus Walleij

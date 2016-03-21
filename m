From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 21 Mar 2016 15:36:49 -0700
Subject: [PATCH v2 0/6] ARM64: meson: GXBaby (S905) and Vega S95 enablement
In-Reply-To: <1456886101-22967-1-git-send-email-afaerber@suse.de>
References: <1456886101-22967-1-git-send-email-afaerber@suse.de>
Message-ID: <CAOi56cXFEUZuu0bJknUYNhfR2jL=LYUTbpnX9diZw2B5JfTaEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 1, 2016 at 6:34 PM, Andreas F?rber <afaerber@suse.de> wrote:

> This series adds initial support for the Amlogic S905 based
> Tronsmart Vega S95 Pro, Meta and Telos TV boxes.
>
> v2:
> * Pick up previously acked "tronsmart" patch instead (Matthias)
> * Drop ARM_GIC selection (Sudeep)
> * Change some compatible strings (Sudeep, Andr?)
> * Squash some node changes/additions
>
> Note: On the Vega S95 I need to change TEXT_OFFSET as follows,
> in order to avoid the vendor U-Boot overwriting itself (fwiu);
> for the Mini Mx that's reportedly not necessary.

FYI, the Amlogic P200 dev board also needs this hack with the factory u-boot.

Kevin

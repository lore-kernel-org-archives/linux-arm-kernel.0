From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Jul 2014 16:53:19 +0200
Subject: [PATCH v2 2/2] devicetree: Add Zynq GPIO devicetree bindings
 documentation
In-Reply-To: <1403091577-10232-2-git-send-email-harinik@xilinx.com>
References: <1403091577-10232-1-git-send-email-harinik@xilinx.com>
 <1403091577-10232-2-git-send-email-harinik@xilinx.com>
Message-ID: <CACRpkdYZ8gQ_-z3Ue3WZZ4FiV8dhw_BZez2-PLpeiBTs-UnNFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 1:39 PM, Harini Katakam <harinik@xilinx.com> wrote:

> From: Harini Katakam <harini.katakam@xilinx.com>
>
> Add gpio-zynq bindings documentation.
>
> Signed-off-by: Harini Katakam <harinik@xilinx.com>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>
> v2 changes:
> Improve description.
(...)
> +- #gpio-cells          : Should be two. First cell is used to mention
> +                         pin number.

Don't call this "pin number", call it "GPIO line number".

Yours,
Linus Walleij

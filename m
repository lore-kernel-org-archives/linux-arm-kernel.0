From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Jun 2017 15:46:16 +0200
Subject: [PATCH] gpio: zynq: Clarify quirk and provide helper function
In-Reply-To: <20170608173207.30056-1-soren.brinkmann@xilinx.com>
References: <20170608173207.30056-1-soren.brinkmann@xilinx.com>
Message-ID: <CACRpkdaZr3iMdeQ+51F6bXa1EVc2jgGyJZhReVF8whn=R=fOog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 8, 2017 at 7:32 PM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> The one quirk used in the zynq GPIO driver was called FOO which is not
> very descriptive. Rename the quirk to IS_ZYNQ as it indicates whether
> the HW is a zynq or zynqmp device to allow handling of device-specific
> differences of the HW.
> Also provide a helper function to test whether the HW is zynq or zynqmp.
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Patch applied.

Yours,
Linus Walleij

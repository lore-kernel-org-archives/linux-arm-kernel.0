From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Aug 2018 09:35:38 +0200
Subject: [PATCH v4 0/5] Add Actions Semi S700 pinctrl support
In-Reply-To: <20180731194743.13678-1-sravanhome@gmail.com>
References: <0180729200038.11795-1-sravanhome@gmail.com>
 <20180731194743.13678-1-sravanhome@gmail.com>
Message-ID: <CACRpkda=q+LZMUN5xJ777ZGWxYRBdZTvG0naNqr5BoLnVQ1=aA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 9:48 PM Saravanan Sekar <sravanhome@gmail.com> wrote:

> This patchset adds pinctrl support for Actions Semi S700 SoC.
> Pinmux functions are only accessible for pin groups while pinconf
> parameters are available for both pin groups and individual pins.
>
> pinctrl driver is verified using the Cubieboard7.
>
> common functionalities from s900 is moved for all Actions Semi
> SoC's usage.
> Common pad control configurations are moved to SoC specific
>
> dts entry for pinctrl depends on clock driver which is still under review:
> https://patchwork.kernel.org/patch/10533959/

So what is the status of this patch set?

I am happy to apply it once you have the right buildtime dependencies
and Manivannan's ACK on the patch set! (Looks good to me.)

Maybe you want to rebase on v4.19-rc1 and resend as v5 before
I do that though?

Yours,
Linus Walleij

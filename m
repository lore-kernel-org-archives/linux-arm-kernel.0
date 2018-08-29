From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed, 29 Aug 2018 13:11:19 +0530
Subject: [PATCH v4 0/5] Add Actions Semi S700 pinctrl support
In-Reply-To: <CACRpkda=q+LZMUN5xJ777ZGWxYRBdZTvG0naNqr5BoLnVQ1=aA@mail.gmail.com>
References: <0180729200038.11795-1-sravanhome@gmail.com>
 <20180731194743.13678-1-sravanhome@gmail.com>
 <CACRpkda=q+LZMUN5xJ777ZGWxYRBdZTvG0naNqr5BoLnVQ1=aA@mail.gmail.com>
Message-ID: <20180829074119.GA24958@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 09:35:38AM +0200, Linus Walleij wrote:
> On Tue, Jul 31, 2018 at 9:48 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
> 
> > This patchset adds pinctrl support for Actions Semi S700 SoC.
> > Pinmux functions are only accessible for pin groups while pinconf
> > parameters are available for both pin groups and individual pins.
> >
> > pinctrl driver is verified using the Cubieboard7.
> >
> > common functionalities from s900 is moved for all Actions Semi
> > SoC's usage.
> > Common pad control configurations are moved to SoC specific
> >
> > dts entry for pinctrl depends on clock driver which is still under review:
> > https://patchwork.kernel.org/patch/10533959/
> 
> So what is the status of this patch set?
>

Oops. This one slipped through the cracks...

> I am happy to apply it once you have the right buildtime dependencies
> and Manivannan's ACK on the patch set! (Looks good to me.)
> 

Sadly mutt played its part on this patchset and 1,3 patches got
deleted accidentally.

> Maybe you want to rebase on v4.19-rc1 and resend as v5 before
> I do that though?
> 

Parthiban,

Can you please rebase and send the next iteration as Linus said. I'll take a
look.

Sorry for the late reply.

Regards,
Mani

> Yours,
> Linus Walleij

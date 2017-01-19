From: hzpeterchen@gmail.com (Peter Chen)
Date: Thu, 19 Jan 2017 14:29:43 +0800
Subject: [PATCH v6 23/25] usb: chipidea: Pullup D+ in device mode via phy
 APIs
In-Reply-To: <CAL_JsqJw-nQj0LtLA_o_Upos_7Kg3bPDoCDghPyOEien_QCLSA@mail.gmail.com>
References: <148418039309.32258.7247753739063801774@sboyd-linaro>
 <20170112095040.GA15726@b29397-desktop>
 <148426139182.20672.2422337338087784924@sboyd-linaro>
 <20170113033536.GA20723@b29397-desktop>
 <148433778067.32719.6179204976256776867@sboyd-linaro>
 <20170116034551.GA27364@b29397-desktop>
 <148467591341.23457.3638889856786813589@sboyd-linaro>
 <20170118073432.GA26659@b29397-desktop>
 <148477287318.29219.9447874002624055587@sboyd-linaro>
 <CAL_JsqJw-nQj0LtLA_o_Upos_7Kg3bPDoCDghPyOEien_QCLSA@mail.gmail.com>
Message-ID: <20170119062943.GA10621@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 02:57:27PM -0600, Rob Herring wrote:
> On Wed, Jan 18, 2017 at 2:54 PM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> > Quoting Peter Chen (2017-01-17 23:34:32)
> >> On Tue, Jan 17, 2017 at 09:58:33AM -0800, Stephen Boyd wrote:
> >> > Quoting Peter Chen (2017-01-15 19:45:51)
> >> > >
> >> > > At include/linux/usb/phy.h, we have .set_vbus interface, maybe you need
> >> > > to port it to generic phy framework.
> >> > >
> >> >
> >> > Ok. I'll look into that. Can the other patches in this series be picked
> >> > up? Otherwise I can resend them all again once I fix the phy_set_mode()
> >> > call location and introduce a new phy op.
> >>
> >> I can pick up chipidea patches after you test the patch I supplied at:
> >>
> >>         [PATCH v6 11/25] usb: chipidea: vbus event may exist before starting
> >> gadget
> >
> > Ok. I've confirmed that this updated patch works fine for me. You can
> > have my Tested-by and Reviewed-by there.
> >
> >>
> >> You may ping other maintainers to pick up other patches.
> >>
> >
> > I was hoping you could pick the beginning of the series up until the PHY
> > drivers, which can go via Kishon's tree. That would mean applying the
> > drivers/of/ part. Rob is that ok?
> 
> Peter, If there's a dependency then please take the patches I've
> acked. That's why I acked them.
> 

Ok, I will do it.

-- 

Best Regards,
Peter Chen

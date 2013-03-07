From: xiechao.mail@gmail.com (Chao Xie)
Date: Thu, 7 Mar 2013 08:57:27 +0800
Subject: [V8 PATCH 01/16] usb: phy: mv_usb2: add PHY driver for marvell
 usb2 controller
In-Reply-To: <20130306164829.GP17833@n2100.arm.linux.org.uk>
References: <1361419646-9052-1-git-send-email-chao.xie@marvell.com>
 <1361419646-9052-2-git-send-email-chao.xie@marvell.com>
 <20130304142143.GG3397@arwen.pp.htv.fi>
 <CADApbeigW=1fQtUZmLMX8H2+0RiiBFjcSBNojQRSZbCa_ORZVw@mail.gmail.com>
 <20130305110457.GF7899@arwen.pp.htv.fi>
 <CADApbeg1KfW4xW=YQcqOwgyaOfes=Nu=9pmtxWgazW23vYS9yw@mail.gmail.com>
 <20130306081044.GD28587@arwen.pp.htv.fi>
 <CADApbej6kscrCYu=hD177tVGGsMTBw2kE+G8PRpVR_5AsJ38tw@mail.gmail.com>
 <20130306164829.GP17833@n2100.arm.linux.org.uk>
Message-ID: <CADApbehSM3Ed05jfkzdU5Jmw+R2ucSWAS4Kbw2VSd2oVO5qKtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 7, 2013 at 12:48 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Mar 06, 2013 at 04:24:58PM +0800, Chao Xie wrote:
>> The clock numbers and names are depent of SOCes,
>
> No they aren't.  The clock names used to describe them in your documentation
> may vary, but their _purpose_ for the sake of the device will be fixed -
> and you should name them appropriately from the _device_ point of view.
>
> Not the SoC point of view.  That way leads to total madness.  We've
> proven this over the years that we've had the clk API and people have
> come up with trash implementations that do that crap.  After many
> years of struggling, they've seen the light and fixed their shite up
> to work the way I originally intended, and... instantly benefited from
> it.
Yes, you are right, and you explained it very clearly.. I understand
what you said.
Our SOC document is lack of this kind of inoformation. I will talk
with the desgin engneer to make clear it, and make a new version of
patches.
Thanks for your review and comments.

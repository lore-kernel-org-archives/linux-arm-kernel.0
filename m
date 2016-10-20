From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 15:46:30 +0200
Subject: [PATCH v2 4/9] pinctrl: sunxi: Deal with configless pins
In-Reply-To: <CACRpkdY3+OnQ6Oo_nx+BrWebeTa=kYhHWSzirk1MxfWWJ--0Sg@mail.gmail.com>
References: <cover.7edc6c25be8a5e2efdda6a82e102dbf7ece6aa64.1476200742.git-series.maxime.ripard@free-electrons.com>
 <d707c657502b87a7f8e70c7b44492bc95939f9f6.1476200742.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v64gBi71W=+Tu2vz94xFDtuRNHUyVWK3ken8CSOWvK5t0g@mail.gmail.com>
 <20161019121614.3crr76qyexhamjiy@lukather>
 <CACRpkdY3+OnQ6Oo_nx+BrWebeTa=kYhHWSzirk1MxfWWJ--0Sg@mail.gmail.com>
Message-ID: <20161020134630.xzkqvm7rokqiecg6@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thu, Oct 20, 2016 at 02:52:54PM +0200, Linus Walleij wrote:
> On Wed, Oct 19, 2016 at 2:16 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Tue, Oct 18, 2016 at 03:47:03PM +0800, Chen-Yu Tsai wrote:
> >> > @@ -342,6 +365,8 @@ static void sunxi_pctrl_dt_free_map(struct pinctrl_dev *pctldev,
> >> >                                     struct pinctrl_map *map,
> >> >                                     unsigned num_maps)
> >> >  {
> >> > +       unsigned long *pinconfig;
> >>
> >> This looks out of place and context?
> >
> > Yeah, sorry, it's just a leftover from the previous version. This has
> > been removed.
> 
> Do you mean you will send a v3 of this series?

Yes, I was waiting for your input to do that, but I guess you're ok
with it :)

> OK stopping to apply then.
>
> But I have already applied patches 1, 2 and 3 so just resend the rest :)

Ack, I'll send it in a moment.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161020/2e925f92/attachment.sig>

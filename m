From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Oct 2016 14:16:14 +0200
Subject: [PATCH v2 4/9] pinctrl: sunxi: Deal with configless pins
In-Reply-To: <CAGb2v64gBi71W=+Tu2vz94xFDtuRNHUyVWK3ken8CSOWvK5t0g@mail.gmail.com>
References: <cover.7edc6c25be8a5e2efdda6a82e102dbf7ece6aa64.1476200742.git-series.maxime.ripard@free-electrons.com>
 <d707c657502b87a7f8e70c7b44492bc95939f9f6.1476200742.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v64gBi71W=+Tu2vz94xFDtuRNHUyVWK3ken8CSOWvK5t0g@mail.gmail.com>
Message-ID: <20161019121614.3crr76qyexhamjiy@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 03:47:03PM +0800, Chen-Yu Tsai wrote:
> > @@ -342,6 +365,8 @@ static void sunxi_pctrl_dt_free_map(struct pinctrl_dev *pctldev,
> >                                     struct pinctrl_map *map,
> >                                     unsigned num_maps)
> >  {
> > +       unsigned long *pinconfig;
> 
> This looks out of place and context?

Yeah, sorry, it's just a leftover from the previous version. This has
been removed.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161019/a478c38b/attachment.sig>

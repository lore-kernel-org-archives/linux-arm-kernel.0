From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Oct 2012 11:44:58 -0700
Subject: [PATCH 08/10] pinctrl: single: support pinconf generic
In-Reply-To: <20121019024012.GP30550@atomide.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-8-git-send-email-haojian.zhuang@gmail.com>
 <CACRpkda0QLkdKns3CXNOijYBjaDtW1QyhNYjTqDvRH-in8pvZQ@mail.gmail.com>
 <20121018222907.GH30550@atomide.com>
 <CAN1soZzsruhWt7VFgf5Fi79npcjLiMSUEVwnE3hR5iWEh+9GRw@mail.gmail.com>
 <20121019024012.GP30550@atomide.com>
Message-ID: <20121019184458.GR4730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [121018 19:41]:
> * Haojian Zhuang <haojian.zhuang@gmail.com> [121018 19:25]:
> > 
> > I wonder whether gpio function in OMAP is also configured in the pinmux
> > register. For example, the function is 3bit field in pinmux register
> > of Marvell's
> > PXA/MMP silicon. GPIO function is the one of function.
> > 
> > If the usage case is same in OMAP silicon, I can merge
> > "pinctrl-single,gpio-mask"
> > with "pinctrl-single,function-mask".
> > 
> > Do we need "pinctrl-single,gpio-disable" at here? I want to remove it,
> > but I don't
> > know whether it's necessary in OMAP case.
> 
> Maybe.. I'll take a look at at that tomorrow.

This one does not apply to v3.7-rc1 because of the pinctrl,bits
support merged from Peter Ujfalusi. Can you please update and
repost?

Thanks,

Tony

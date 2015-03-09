From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 9 Mar 2015 09:29:31 +0000
Subject: [PATCH v10 1/2] mfd: AXP20x: Add bindings documentation
In-Reply-To: <CAGb2v65-kq=usC8Xip56p9wbs7RMUd0=sXcjcgY3Ec33bxEUaw@mail.gmail.com>
References: <1424431168-25157-1-git-send-email-wens@csie.org>
 <1424431168-25157-2-git-send-email-wens@csie.org>
 <CAGb2v65-kq=usC8Xip56p9wbs7RMUd0=sXcjcgY3Ec33bxEUaw@mail.gmail.com>
Message-ID: <20150309092931.GC3427@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 07 Mar 2015, Chen-Yu Tsai wrote:

> On Fri, Feb 20, 2015 at 7:19 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> > From: Carlo Caione <carlo@caione.org>
> >
> > Bindings documentation for the AXP20x driver. In this file also
> > sub-nodes are documented.
> >
> > Signed-off-by: Carlo Caione <carlo@caione.org>
> > [wens at csie.org: clarify interrupt source for the axp PMIC]
> > [wens at csie.org: explain dcdc-workmode in detail and trim lines to 80 chars]
> > [wens at csie.org: make regulator supplies optional if using unregulated input]
> > [wens at csie.org: use cubieboard2 regulator nodes as example]
> > [wens at csie.org: x-powers,dcdc-workmode default changed to 'current hardware
> >                 setting']
> > [wens at csie.org: reorganized regulator related properties into separate
> >                 section.]
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> 
> Ping?

Don't do that.  It won't speed up the review.

If you think your set has been fogotten about (this one has not)
resend with s/PATCH/RESEND/ in the subject line.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

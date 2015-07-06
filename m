From: yh.huang@mediatek.com (YH Huang)
Date: Mon, 6 Jul 2015 20:43:31 +0800
Subject: [PATCH v3 0/2] Add MediaTek display PWM driver
In-Reply-To: <CAGS+omANeUxcRdY-qQzxjtBY5Yhx56mSneuuXh+bGjbahKhDeA@mail.gmail.com>
References: <1435590211-38854-1-git-send-email-yh.huang@mediatek.com>
 <CAGS+omANeUxcRdY-qQzxjtBY5Yhx56mSneuuXh+bGjbahKhDeA@mail.gmail.com>
Message-ID: <1436186611.32512.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

I will add PWM dtsi in the next patch and also fix the code with your
suggestions in other mails.

Regards,
YH Huang

On Tue, 2015-06-30 at 14:35 +0800, Daniel Kurtz wrote:
> Hi YH,
> 
> Please also include a patch that adds PWM bindings to mt8173.dtsi.
> The clock definitions (CLK_MM_DISP_PWM*) are added by James LIao's patch:
>   clk: mediatek: Add subsystem clocks of MT8173
> 
> I think it is ok to mention in the cover-letter that the PWM .dtsi
> change depends on that other patch.
> 
> Also, cover-letters usually contain a "shortlog" and diffstatm that
> gives summary of patches and changed files, generated along with the
> patches using:
>  git format-patch --cover-letter
> 
> Thanks,
> -Daniel
> 
> On Mon, Jun 29, 2015 at 11:03 PM, YH Huang <yh.huang@mediatek.com> wrote:
> > This patch series add the use of display PWM driver and documentation
> > for Mediatek SoCs. The driver is used to support the backlight of
> > the panel. This is based on v4.1-rc1.
> >
> > Change in v3:
> > 1. Add suspend/resume function
> > 2. Fix the formula for high_width calculation
> > 3. Rewrite some code to make it easier to read
> > 4. Add more information in the commit message
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

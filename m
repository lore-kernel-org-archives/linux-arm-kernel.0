From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 11 Apr 2012 14:51:53 +0200
Subject: [PATCH v6 04/17] pwm: Add table-based lookup for static mappings
In-Reply-To: <20120411123815.GB2445@S2101-09.ap.freescale.net>
References: <1334070400-25013-1-git-send-email-thierry.reding@avionic-design.de>
 <1334070400-25013-5-git-send-email-thierry.reding@avionic-design.de>
 <20120411123815.GB2445@S2101-09.ap.freescale.net>
Message-ID: <20120411125153.GA3234@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shawn Guo wrote:
> On Tue, Apr 10, 2012 at 05:06:27PM +0200, Thierry Reding wrote:
[...]
> > +	static struct pwm_lookup board_pwm_lookup[] = {
> > +		PWM_LOOKUP("tegra-pwm", 0, "pwm-backlight"),
> 
> PWM_LOOKUP takes 4 parameters now.  Other than that,

Right, I missed that.

> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120411/4526fee1/attachment.sig>

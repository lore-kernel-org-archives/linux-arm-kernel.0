From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 13 Aug 2015 16:50:06 +0200
Subject: [PATCH v5 2/2] pinctrl: rockchip: only enable gpio clock when it
 setting
In-Reply-To: <CACRpkdYYdqm+CfejMA6yrDheNA=3H13zsW2XuKqqYDRNMS=07w@mail.gmail.com>
References: <1439287924-6988-1-git-send-email-hl@rock-chips.com>
 <2167165.ooWgarx4Ov@diego>
 <CACRpkdYYdqm+CfejMA6yrDheNA=3H13zsW2XuKqqYDRNMS=07w@mail.gmail.com>
Message-ID: <1632762.z1JEYVnjv5@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 13. August 2015, 16:11:38 schrieb Linus Walleij:
> On Thu, Aug 13, 2015 at 2:37 PM, Heiko St?bner <heiko@sntech.de> wrote:
> >> Patch applied with Doug's test tags etc.
> > 
> > did you  also take the first patch?
> > 
> > Aka bot should probably stay together (hence Stephen's Ack for the clock
> > change), as the dynamically controlling the gpio clocks exposes the
> > pclk_pd_pmu.
> 
> OK wasn't obvious to me, patch 1/2 applied to the pinctrl tree now.

Thanks for picking patch 1/2 too.

Both me and Lin seem to have forgotten to mention this in this new revision 
(sorry about that), as it was discussed in a previous revision only.

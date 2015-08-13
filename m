From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Aug 2015 16:11:38 +0200
Subject: [PATCH v5 2/2] pinctrl: rockchip: only enable gpio clock when it
 setting
In-Reply-To: <2167165.ooWgarx4Ov@diego>
References: <1439287924-6988-1-git-send-email-hl@rock-chips.com>
 <1439287924-6988-2-git-send-email-hl@rock-chips.com>
 <CACRpkda0FXz1dpdS-wLRNmkt1KBESMyCWKMMa0ArH9Z-L=i_sw@mail.gmail.com>
 <2167165.ooWgarx4Ov@diego>
Message-ID: <CACRpkdYYdqm+CfejMA6yrDheNA=3H13zsW2XuKqqYDRNMS=07w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 2:37 PM, Heiko St?bner <heiko@sntech.de> wrote:

>> Patch applied with Doug's test tags etc.
>
> did you  also take the first patch?
>
> Aka bot should probably stay together (hence Stephen's Ack for the clock
> change), as the dynamically controlling the gpio clocks exposes the
> pclk_pd_pmu.

OK wasn't obvious to me, patch 1/2 applied to the pinctrl tree now.

Yours,
Linus Walleij

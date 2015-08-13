From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 13 Aug 2015 14:37:36 +0200
Subject: [PATCH v5 2/2] pinctrl: rockchip: only enable gpio clock when it
 setting
In-Reply-To: <CACRpkda0FXz1dpdS-wLRNmkt1KBESMyCWKMMa0ArH9Z-L=i_sw@mail.gmail.com>
References: <1439287924-6988-1-git-send-email-hl@rock-chips.com>
 <1439287924-6988-2-git-send-email-hl@rock-chips.com>
 <CACRpkda0FXz1dpdS-wLRNmkt1KBESMyCWKMMa0ArH9Z-L=i_sw@mail.gmail.com>
Message-ID: <2167165.ooWgarx4Ov@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Am Donnerstag, 13. August 2015, 14:24:28 schrieb Linus Walleij:
> On Tue, Aug 11, 2015 at 12:12 PM, Lin Huang <hl@rock-chips.com> wrote:
> > gpio can keep state even the clock disable, for save power
> > consumption, only enable gpio clock when it setting
> > 
> > Signed-off-by: Lin Huang <hl@rock-chips.com>
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > Changes in v5:
> > -rebase patch
> 
> Patch applied with Doug's test tags etc.

did you  also take the first patch?

Aka bot should probably stay together (hence Stephen's Ack for the clock 
change), as the dynamically controlling the gpio clocks exposes the 
pclk_pd_pmu.


Heiko

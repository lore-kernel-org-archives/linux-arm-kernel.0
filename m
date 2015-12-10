From: biao.huang@mediatek.com (biao huang)
Date: Thu, 10 Dec 2015 10:34:52 +0800
Subject: [PATCH 4/5] pinctrl: mediatek: Add Pinctrl/GPIO/EINT driver for
 mt2701
In-Reply-To: <CACRpkda2vgrVEisH=akc5aj6h4LW+mBTqgbAiF3E=3zcu6A28A@mail.gmail.com>
References: <1448527472-20651-1-git-send-email-biao.huang@mediatek.com>
 <1448527472-20651-5-git-send-email-biao.huang@mediatek.com>
 <CACRpkda2vgrVEisH=akc5aj6h4LW+mBTqgbAiF3E=3zcu6A28A@mail.gmail.com>
Message-ID: <1449714892.17341.3.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-12-09 at 23:52 +0100, Linus Walleij wrote:
> On Thu, Nov 26, 2015 at 9:44 AM, Biao Huang <biao.huang@mediatek.com> wrote:
> 
> > Add mt2701 support using mediatek common pinctrl driver.
> > MT2701 have some special pins need an extra setting register
> > than other ICs, so adding this support to common code.
> >
> > Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> 
> This looks uncontroversial, but I would like to have some of the
> other Mediatek driver authors send their Ack/Review tags,
> so Hongzhou & Yingjoe: can you review this and the other
> patch to the pin control driver?
The v2 patch will be sent in next week, and there are some changes in
mt2701 drivers. And I'll add Hongzhou & Yingjoe to review these patches.
> 
> Yours,
> Linus Walleij

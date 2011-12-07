From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Dec 2011 23:38:45 +0100
Subject: [PATCH 4/7] spi/pl022: move device disable to workqueue thread
In-Reply-To: <20111207202203.GA3744@pengutronix.de>
References: <1321950301-4782-1-git-send-email-linus.walleij@stericsson.com>
 <4ECB5D2E.1000906@st.com>
 <CACRpkdYSGWAB29gHhKjpyEQDAaLoTbPM6-Qz0FosL3X4TNwxdg@mail.gmail.com>
 <20111207202203.GA3744@pengutronix.de>
Message-ID: <CACRpkdZS_+e04b42nEJVsTRAiV9ovdWxde1DRTR_m_JBAFMdUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 7, 2011 at 9:22 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:

>> But I'll take it out when I add you Reviewed-by...
>
> Does that imply you will send out a V3 of this series somewhen and I
> don't need to add this right now to the for-grant branch I am currently
> preparing?

No I just added them to my branch and waited for Grant to get
back online.

The patches and ACKs are accumulated on this branch:

git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git pl022

If you want to make a huge bundle to send to Grant, please pull
this into your tree.

Thanks,
Linus Walleij

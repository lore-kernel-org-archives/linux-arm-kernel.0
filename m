From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Nov 2013 21:09:46 +0100
Subject: [PATCH v7 0/7] pinctrl: imx27: imx27 pincontrol driver
In-Reply-To: <20131113143557.GA17816@S2101-09.ap.freescale.net>
References: <1384246210-9257-1-git-send-email-mpa@pengutronix.de>
 <20131113143557.GA17816@S2101-09.ap.freescale.net>
Message-ID: <CACRpkdaFpvu8wjwAufu==G=KmY_N_Ouo+NPiKi=Fi+OdeZA8kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 3:36 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Nov 12, 2013 at 09:50:03AM +0100, Markus Pargmann wrote:
>> Hi,
>>
>> This series contains only DTS changes for imx27-pinctrl. It depends on the
>> incremental driver patch which allows iomux subdevices [1].
>
> Applied patches #1, #2 and #7.
>
> Unless LinusW create a topic branch for that dependency, I cannot apply
> the rest.

Its on the "devel" branch in the pinctrl tree but I'd wait a while
for it to settle in linux-next etc before pulling that in, but you can
do that after handshake with me (so I know which commit you
pulled so I cannot rebase behind that point).

Yours,
Linus Walleij

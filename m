From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Oct 2014 18:03:27 +0100
Subject: [PATCH v2 3/4] pinctrl: rockchip: Parse pin groups before calling
 pinctrl_register()
In-Reply-To: <2697554.Rv8qaADZsg@diego>
References: <1413913655-22351-1-git-send-email-dianders@chromium.org>
 <1413913655-22351-3-git-send-email-dianders@chromium.org>
 <2697554.Rv8qaADZsg@diego>
Message-ID: <CACRpkdas7K-JUZJSRsgmcBVdxK+mb3VV7TxFXYh91d4n7+eizQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 23, 2014 at 6:26 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Am Dienstag, 21. Oktober 2014, 10:47:34 schrieb Doug Anderson:
>> Just like in (529301c pinctrl: samsung: Parse pin groups before
>> calling pinctrl_register()), Rockchip also needs to parse pin groups
>> earlier to make hogs work.
>>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> Tested-by: Chris Zhong <zyw@rock-chips.com>
>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Heiko, can you collect this for a pull request?

Yours,
Linus Walleij

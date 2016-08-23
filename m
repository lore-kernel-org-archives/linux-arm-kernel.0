From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Aug 2016 11:27:10 +0200
Subject: [PATCH 1/2] pinctrl: sunxi: fix uart1 CTS/RTS pins at PG on
 A23/A33
In-Reply-To: <20160823064755.GA2598@lukather>
References: <20160823055826.20591-1-icenowy@aosc.xyz>
 <20160823064755.GA2598@lukather>
Message-ID: <CACRpkdaHY=TFE3H=CM2fu3etHcWq569MDOE2cJY=PGZauHwO2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 8:47 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Aug 23, 2016 at 01:58:25PM +0800, Icenowy Zheng wrote:
>> PG8, PG9 is said to be the CTS/RTS pins for UART1 according to the A23/33
>> datasheets. However, the function is wrongly named "uart2" in the pinctrl
>> driver. This patch fixes this by modifying them to be named "uart1".
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>
> This looks good, but could you send it to stable?

If that is an ACK I can tag it for stable when applying.

Yours,
Linus Walleij

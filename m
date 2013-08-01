From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 1 Aug 2013 15:20:40 +0200
Subject: [RFC 4/8] pinctrl: imx: Support imx21 register format
In-Reply-To: <20130728102215.GH16871@s25.your-server.de>
References: <1374938808-27316-1-git-send-email-mpa@pengutronix.de>
 <1374938808-27316-5-git-send-email-mpa@pengutronix.de>
 <20130728083436.GI2737@pengutronix.de>
 <20130728102215.GH16871@s25.your-server.de>
Message-ID: <CACRpkdbeYo86u07EWeSVt8SYKL-eqQf3vpX5rRXQx4hNh0EbvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 28, 2013 at 12:22 PM, Markus Pargmann <mpa@pengutronix.de> wrote:

>> Is it really worth sharing the i.MX1/21/27 support with the imx driver?
>> It seems most of the code is rewritten. I just tried and removed all
>> lines from pinctrl-imx.c you don't use. There's not much left to share.
>
> Yes it's really not that much to share. I will move it to a seperate
> file for imx1/21/27.

OK I'll wait for a v2 version of this patch set before reviewing.

Yours,
Linus Walleij

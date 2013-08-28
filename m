From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Aug 2013 14:19:19 +0200
Subject: [PATCH v5 0/3] arm: mvebu: fix resource leak
In-Reply-To: <20130827144253.GC19598@titan.lakedaemon.net>
References: <1377578476-3268-1-git-send-email-jszhang@marvell.com>
 <20130827144253.GC19598@titan.lakedaemon.net>
Message-ID: <CACRpkdZD5mjf9KUJD3fSM7z7jp6UBabfjAUAUT=TDLGbbJLjow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 4:42 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Tue, Aug 27, 2013 at 12:41:13PM +0800, Jisheng Zhang wrote:

>>   pinctrl: mvebu: Convert to use devm_ioremap_resource
>
> Previously Acked patch 3 for LinusW

I've taken that one into the pinctrl tree now.

Yours,
Linus Walleij

From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 6 Sep 2016 00:19:07 +0200
Subject: [PATCH] pinctrl: imx: output one pin/config pair per line in
 pinconf-groups
In-Reply-To: <1471644337-10162-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1471644337-10162-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <CACRpkdbwh=k3GD-7wSq9iBoBhyQ4SFD75xaLnx6g8WbRZ5X7Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 20, 2016 at 12:05 AM, Vladimir Zapolskiy
<vladimir_zapolskiy@mentor.com> wrote:

> cat /sys/kernel/debug/pinctrl/${pinctrl}/pinconf-groups output is
> hardly readable, if a pin group contains more than one pin the output
> is glued and looks like this:
>
>   MX6Q_PAD_SD1_DAT0: 0x17071MX6Q_PAD_SD1_CMD: 0x17071MX6Q_PAD_SD1_CLK: 0x17071
>
> Add two space indentation and a new line separator to improve
> readability of the output.
>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

Patch applied with Shawn's ACK.

Yours,
Linus Walleij

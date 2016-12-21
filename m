From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Wed, 21 Dec 2016 16:30:11 +0300
Subject: [v4,
 1/3] ARM: dts: vf610-zii-dev-rev-b: Remove leftover PWM pingroup
In-Reply-To: <1482131877-6097-1-git-send-email-andrew.smirnov@gmail.com>
References: <1482131877-6097-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <1482327011-19979-1-git-send-email-nikita.yoush@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Remove pwm0grp since it is:
>
>	a) Not referenced anywhere in the DTS file (unlike Tower board it
>	is based on, this board does not use/expose FTM0)
>
>	b) Configures PTB2 and PTB3 in a way that contradicts
>	pinctrl-mdio-mux
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Tested-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

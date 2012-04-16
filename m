From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 16 Apr 2012 11:46:49 +0800
Subject: [PATCH 1/3] pinctrl: pinctrl-imx: add imx pinctrl core driver
In-Reply-To: <20120416034713.GB17173@shlinux2.ap.freescale.net>
References: <1334333915-1174-1-git-send-email-b29396@freescale.com>
 <20120414134814.GA3852@pengutronix.de>
 <CAA+hA=T0FAfuGKcW0vAKO+OWyFdM-6vQqVo53xKf8y28m7gPOQ@mail.gmail.com>
 <20120415141736.GG24997@S2101-09.ap.freescale.net>
 <20120416034713.GB17173@shlinux2.ap.freescale.net>
Message-ID: <20120416034646.GI24997@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2012 at 11:47:14AM +0800, Dong Aisheng wrote:
...
> Good suggestion.
> I can do it and it's easy to change.
> But as i said above, before the dtc macro support is available, the pinctrl
> setting in dts file will be hard to read since it's all raw data.
> It becomes
> fsl,pins = <1 2 3 4 5 6 ....>;
> People have to search the binding doc to see what the data means.
> 
It does not make the thing any worse.  You were asking people to search
pinctrl-imx6q.c for the meaning of the following.

  fsl,mux = <0 0 1 1 1 1 1 1 1 1>;

IMO, it makes a bit more sense to look at binding doc than code to
understand the dts file.

> The question is how long the dtc macro support will be available?
> I'm very willing to do like as you said if it's just a short time.
> But if it's long time, do we still want to lose the readability right now?
> 
The point is with my suggestion taken, we do not need to change code
when the dtc macro support is available.

-- 
Regards,
Shawn

From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 19 Oct 2015 12:12:12 +0200
Subject: [PATCH v3 00/12] pwm: add support for atomic update
In-Reply-To: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <2341981.a79ioYM9Es@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

Am Montag, 21. September 2015, 11:33:17 schrieb Boris Brezillon:
> Hello,
> 
> This series adds support for atomic PWM update, or IOW, the capability
> to update all the parameters of a PWM device (enabled/disabled, period,
> duty and polarity) in one go.

is anything more blocking this series? It's now sitting on the lists for 
nearly a month and everybody seems happy with it, so it would be really nice 
to have in mainline :-) .

Especially as this also makes it possible for Rockchip Chromebooks to actually 
control the logic-regulator that is implemented as pwm-regulator there.


Thanks
Heiko

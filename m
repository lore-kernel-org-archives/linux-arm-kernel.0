From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 28 Feb 2018 12:59:14 +0100
Subject: [PATCH] soc: rockchip: power-domain: remove PM clocks
In-Reply-To: <20180228111113.13639-1-jeffy.chen@rock-chips.com>
References: <20180228111113.13639-1-jeffy.chen@rock-chips.com>
Message-ID: <4580848.piTrlVmp9H@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffy,

Am Mittwoch, 28. Februar 2018, 12:11:13 CET schrieb Jeffy Chen:
> Currently we are adding all of the attached devices' clocks as pm clocks
> and enable them when powering on the power domain.
> 
> This seems unnecessary, because those clocks are already controlled in
> the devices' drivers with better error handling.
> 
> Tested on my chromebook minnie(rk3288) and chromebook kevin(rk3399).
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

Looks ok to me and does not seem to interfere with the synchronous
reset that still stays intact.

@Ceasar: any objections?


Heiko

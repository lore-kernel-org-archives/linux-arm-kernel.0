From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Jan 2015 13:52:14 -0800
Subject: [PATCH v4 2/2] ARM: digicolor: select syscon and timer
In-Reply-To: <2d0359c67f731aab3befa4b3f059cc9fdbcf2ff6.1422481097.git.baruch@tkos.co.il>
References: <8b74c50aebadc781a5aa8061f7639c9164433e84.1422481097.git.baruch@tkos.co.il>
 <2d0359c67f731aab3befa4b3f059cc9fdbcf2ff6.1422481097.git.baruch@tkos.co.il>
Message-ID: <20150129215214.GA20785@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 12:04:11AM +0200, Baruch Siach wrote:
> The digicolor interrupt controller driver now needs syscon.
> 
> Also, as per clocksource maintainer request, we now have a separate config
> symbol, CONFIG_DIGICOLOR_TIMER, for the digicolor timer.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Thanks, applied 1-2.

-Olof

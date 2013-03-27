From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Mar 2013 20:34:01 +0800
Subject: IMX: board hardware macro
In-Reply-To: <5152B82D.8080505@linaro.org>
References: <515221BE.8050808@linaro.org>
 <20130327063306.GC2767@r65073-Latitude-E6420>
 <5152B82D.8080505@linaro.org>
Message-ID: <20130327123359.GD2674@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 10:13:17AM +0100, Daniel Lezcano wrote:
> Do these macros exist ?

There is cpu_is_mx51(), but no cpu_is_mx6() stuff.  I do not understand
why these are needed.  The cpuidle initialization should be done in SoC
specific hook like how it's done for imx6q right now.  So why do you
need such macros?

Shawn

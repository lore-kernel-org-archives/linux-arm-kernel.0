From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Nov 2012 17:59:25 +0100
Subject: [PATCH] clocksource: use clockevents_config_and_register() where
 possible
In-Reply-To: <1353936700-15255-1-git-send-email-shawn.guo@linaro.org>
References: <1353936700-15255-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <50B8E5ED.3000805@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 26/11/2012 14:31, Shawn Guo a ?crit :
> The clockevent core is able to figure out the best mult and shift,
> calculate min_delta_ns and max_delta_ns, with the necessary info passed
> into clockevents_config_and_register().  Use this combined configure
> and register function where possible to make the codes less error prone
> and gain some positive diff stat.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

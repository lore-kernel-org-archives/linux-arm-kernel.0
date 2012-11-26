From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 27 Nov 2012 09:04:36 +1300
Subject: [PATCH] ARM: use clockevents_config_and_register() where possible
In-Reply-To: <1353936857-15313-1-git-send-email-shawn.guo@linaro.org>
References: <1353936857-15313-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1353960276.2327.1.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-11-26 at 21:34 +0800, Shawn Guo wrote:
> The clockevent core is able to figure out the best mult and shift,
> calculate min_delta_ns and max_delta_ns, with the necessary info passed
> into clockevents_config_and_register().  Use this combined configure
> and register function where possible to make the codes less error prone
> and gain some positive diff stat.

Acked-by: Tony Prisk <linux@prisktech.co.nz>

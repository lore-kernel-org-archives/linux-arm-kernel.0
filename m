From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 24 Aug 2015 19:04:29 +0200
Subject: [PATCH v2 3/3] ARM: dts: rockchip: correct regulator power states
 for suspend
In-Reply-To: <1440022721-73712-3-git-send-email-briannorris@chromium.org>
References: <1440022721-73712-1-git-send-email-briannorris@chromium.org>
 <1440022721-73712-3-git-send-email-briannorris@chromium.org>
Message-ID: <2616064.1Av4bHmkNF@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 19. August 2015, 15:18:41 schrieb Brian Norris:
> When getting translated from a downstream device tree that used slightly
> different DT bindings, these regulators got labeled with the
> "on-in-suspend" state, when they were actually supposed to be turned off
> for S3 suspend. This was harmless, but not intentional, AFAICT.
> 
> Let's turn them off to get the optimal power state.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> ---

applied to my dts branch for 4.3

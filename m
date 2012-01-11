From: arnd@linaro.org (Arnd Bergmann)
Date: Wed, 11 Jan 2012 15:10:12 +0000
Subject: [PATCH 5/7] at91 : fix dirty hack for the selfrefresh function
In-Reply-To: <1326293740-15735-6-git-send-email-daniel.lezcano@linaro.org>
References: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
 <1326293740-15735-6-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <201201111510.12164.arnd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 January 2012, Daniel Lezcano wrote:
> Remove the static variable saved_lpr1 defined in the header and
> define a structure to be common with all the functions.
> That will cleanly unify the function definitions.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Good catch!

Acked-by: Arnd Bergmann <arnd@arndb.de>

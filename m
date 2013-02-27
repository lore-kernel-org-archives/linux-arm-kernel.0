From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 27 Feb 2013 10:39:14 +0530
Subject: [PATCH 1/4] time : pass broadcast parameter
In-Reply-To: <1361917047-29230-2-git-send-email-daniel.lezcano@linaro.org>
References: <1361917047-29230-1-git-send-email-daniel.lezcano@linaro.org>
 <1361917047-29230-2-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <512D94FA.7070207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 February 2013 03:47 AM, Daniel Lezcano wrote:
> The broadcast timer could be passed as parameter to the function
> instead of using again tick_broadcast_device.evtdev which was
> previously used in the caller function.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
The change doesn't buy us as such even after looking
at next patch which tries to use bc. No strong opinion
though.

Regards,
Santosh

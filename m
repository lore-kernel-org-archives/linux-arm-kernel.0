From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 12 Sep 2014 15:05:37 -0700
Subject: [PATCH RESEND v9 1/5] rtc: max77686: Allow the max77686 rtc to
 wakeup the system
In-Reply-To: <1410509864-10019-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1410509864-10019-1-git-send-email-javier.martinez@collabora.co.uk>
 <1410509864-10019-2-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140912150537.56419981804c68f9108a22b6@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Sep 2014 10:17:39 +0200 Javier Martinez Canillas <javier.martinez@collabora.co.uk> wrote:

> From: Doug Anderson <dianders@chromium.org>
> 
> The max77686 includes an RTC that keeps power during suspend.  It's
> convenient to be able to use it as a wakeup source.
> 
> NOTE: due to wakeup ordering problems this patch alone doesn't work so
> well on exynos5250-snow.  You also need something that brings the i2c
> bus up before the max77686 wakeup runs.

I removed this paragraph.

> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

And I rewrote this to Signed-off-by:, as you were on the patch delivery
path. Documentation/SubmittingPatches section 12 has the gory details.

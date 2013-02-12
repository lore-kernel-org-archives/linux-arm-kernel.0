From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 12 Feb 2013 14:04:37 -0800
Subject: [PATCH 06/16] ARM idle: delete pm_idle
In-Reply-To: <9838a4aeee256adeaef90efe56df2c9988206982.1360475150.git.len.brown@intel.com>
 (Len Brown's message of "Sun, 10 Feb 2013 00:58:13 -0500")
References: <1360475903-30007-1-git-send-email-lenb@kernel.org>
 <2b219d07e0f287c2c713f5465fc8646158fa986e.1360475150.git.len.brown@intel.com>
 <9838a4aeee256adeaef90efe56df2c9988206982.1360475150.git.len.brown@intel.com>
Message-ID: <87pq05i3yi.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Len Brown <lenb@kernel.org> writes:

> From: Len Brown <len.brown@intel.com>
>
> pm_idle() on ARM was a synonym for default_idle(),
> so simply invoke default_idle() directly.
>
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: linux-arm-kernel at lists.infradead.org

Looks good to me.

Tested this patch along with 15/16 (removes global declaration) on an
ARM platform (TI OMAP3) with and without CPUidle, and things continue to
work as expected:

Reviewed-by: Kevin Hilman <khilman@linaro.org>
Tested-by: Kevin Hilman <khilman@linaro.org>

Kevin

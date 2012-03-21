From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 21 Mar 2012 15:06:30 +0530
Subject: [RFC][PATCH 0/7] OMAP4 cpuidle cleanup
In-Reply-To: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CAMQu2gxit11dSbruPLCGx37TRwo9mwNCN9JXn0fZLDTVGu2GcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2012 at 2:57 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> This patchset is a proposition to improve a bit the code.
> The changes are code cleanup and does not change the behavior of the
> driver itself.
>
Thanks. Will have a look at your series.

> A couple a things call my intention. Why the cpuidle device is set for cpu0 only
Because the mainline code CPUIDLE is supported along with CPUhotplug.
This is going to change though with Couple CPUIDLE and corresponding
OMAP updates.

> and why the WFI is not used ?
>
I didn't get this question. Do you mean the generic WFI?
If yes, then, it's mainly because OMAP need additional
custom barriers.

Regards
Santosh

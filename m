From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 30 Oct 2014 13:47:27 -0700
Subject: [PATCH v3 4/9] drivercore / platform: Keep PM domain powered
 during ->probe()
In-Reply-To: <1413208930-26019-5-git-send-email-ulf.hansson@linaro.org> (Ulf
 Hansson's message of "Mon, 13 Oct 2014 16:02:05 +0200")
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
 <1413208930-26019-5-git-send-email-ulf.hansson@linaro.org>
Message-ID: <7hoast8eu8.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> To sucessfully probe some devices their corresponding PM domains may
> need to be powered.

Isn't that what pm_runtime_get*() is supposed to be doing?  Why isn't
that working?

Kevin

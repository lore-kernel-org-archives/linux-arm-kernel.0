From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 29 Aug 2017 13:21:25 +0200
Subject: [PATCH 9/9] clocksource/drivers/bcm2835: Remove message on memory
 allocation failure
In-Reply-To: <1503999271-15712-9-git-send-email-daniel.lezcano@linaro.org>
References: <20170829093354.GA2572@mai>
 <1503999271-15712-1-git-send-email-daniel.lezcano@linaro.org>
 <1503999271-15712-9-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1822c0d4-8f5d-611c-21df-4945f298be0a@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I would prefer to use the wording ?for a? instead of ?on? in the commit subject.


> The bcm2835_timer_init() function emits an error message in case of a memory
> allocation failure. This is pointless as the mm core already do that.

Does this commit message contain a typo?
Would a wording like ?? does that already.? be more appropriate here?

Regards,
Markus

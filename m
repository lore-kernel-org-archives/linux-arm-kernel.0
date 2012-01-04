From: rob.lee@linaro.org (Rob Lee)
Date: Wed, 4 Jan 2012 12:05:35 -0600
Subject: [RFC PATCH 0/8] Add common ARM cpuidle init code
In-Reply-To: <4F041933.70506@linaro.org>
References: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
 <201112081537.04789.arnd.bergmann@linaro.org>
 <4F031698.4010501@linaro.org>
 <201201031602.01072.arnd.bergmann@linaro.org>
 <4F041933.70506@linaro.org>
Message-ID: <CAMXH7KEPyK31RT=MZaFdKAQRssX9rOkmcQKhDh5y1+K9mwEqNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn and Arnd,

Sorry for my late reply.  For some reason, I didn't see this thread
until after Daniel's response.

Per an offline conversation Daniel and I had, since Daniel has
volunteered to move the other drivers and has already submitted a RFC
for at91 cpuidle, I will submit a v3 of the common cpuidle code which
will include moving the i.MX5 cpuidle code to drivers/cpuidle to have
the best chance of getting this code and an i.MX5 cpuidle driver into
3.3.  If my code get's merged, then Daniel will re-base his changes
against the common code.

From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 May 2012 21:25:14 +0000
Subject: [PATCH 00/18] DT enablement for Snowball
In-Reply-To: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
Message-ID: <201205172125.14937.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 May 2012, Lee Jones wrote:
> Hopefully the penultimate large patch-stack for Snowball
> enablement. After that only bits and bobs will remain.

Hi Lee,

I'm quite happy with the series overall, but it's really late for v3.5 now,
and I can't really judge the quality of the regulator changes. If LinusW,
Mark, Grant and Olof are all ok with this series, I think we can add it
in as a late branch for the 3.5 merge window. If there are serious
objections I think we should do it for 3.6 instead.

I've commented on one patch that looks wrong to me, but it won't be hard
to fix that.

	Arnd

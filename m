From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 May 2014 12:37:19 -0600
Subject: [PATCH 3/3] clocksource: tegra: Use uS counter as delay timer
In-Reply-To: <1400600176-435-4-git-send-email-pdeschrijver@nvidia.com>
References: <1400600176-435-1-git-send-email-pdeschrijver@nvidia.com>
 <1400600176-435-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <537BA0DF.60003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2014 09:36 AM, Peter De Schrijver wrote:
> All Tegra SoCs have a freerunning microsecond counter which can be used as a
> delay timer.

Patch 3 looks fine to me. I'll be happy to apply it once the other
patches are applied (or ack it or create a topic branch containing all 3
if needed, so it can be applied without waiting for dependencies to
filter up to Linus).

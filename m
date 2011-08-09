From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 09 Aug 2011 15:36:04 +0400
Subject: [PATCH] ARM: EXYNOS4: Fix the IRQ definitions for MIPI CSIS device
In-Reply-To: <1312809118-6181-1-git-send-email-s.nawrocki@samsung.com>
References: <1312809118-6181-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <4E411BA4.2020909@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08-08-2011 17:11, Sylwester Nawrocki wrote:

> This is a regression fix after migration to the external GIC.
> The breakage has been introduced in commit:
> "ARM: EXYNOS4: modify interrupt mappings for external GIC"

    Would be good to also cite that commit's ID for gitweb.

> Signed-off-by: Sylwester Nawrocki<s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>

WBR, Sergei

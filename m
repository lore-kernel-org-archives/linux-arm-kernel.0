From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 30 Nov 2010 08:47:54 +0000
Subject: [PATCH 09/10] ARM S3C2412: Fix typo in CONFIG_CPU_S3C2412_ONLY
	definition
In-Reply-To: <1290969027-10178-9-git-send-email-jekhor@gmail.com>
References: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
	<1290969027-10178-9-git-send-email-jekhor@gmail.com>
Message-ID: <4CF4BA3A.8020200@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/11/10 18:30, Yauhen Kharuzhy wrote:
> Dependency on (CPU_S3C2416 is not selected) was defined as "!CPU_2416",
> instead of "!CPU_S3C2416". Fix it.

ok, applied.

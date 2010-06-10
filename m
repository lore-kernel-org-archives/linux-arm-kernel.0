From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 10 Jun 2010 13:43:04 -0700
Subject: [PATCH] s5pc110: SDHCI-s3c can override host capabilities
In-Reply-To: <20100605024053.GA23419@july>
References: <20100605024053.GA23419@july>
Message-ID: <20100610134304.c109811a.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 05 Jun 2010 11:40:53 +0900
Kyungmin Park <kmpark@infradead.org> wrote:

> From: Kyungmin Park <kmpark@infradead.org>
> To: linux-arm-kernel at lists.infradead.org, linux-mmc at vger.kernel.org, akpm at linux-foundation.org, ben-linux at fluff.org
> Subject: [PATCH] s5pc110: SDHCI-s3c can override host capabilities
> Date: Sat, 05 Jun 2010 11:40:53 +0900
> User-Agent: Mutt/1.5.14 (2007-02-12)
> 
> Each board can override the default sdhci host capabilities.
> Some board has broken features by hardwares and support 8-bit bandwidth.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

The way this patch was presented, it will go into git with an Author:
address of "kmpark at infradead.org", but a Signed-off-by: address of
"kyungmin.park at samsung.com".  Which is a little odd.

The way to prevent that is to put an explicit "From:" line at the top
of the changelog.  If that line is absent, people's tools will fall
back to the From: line in the mail headers, which is what happened
here.

Please let me know if you want me to make any changes to these three
patches.

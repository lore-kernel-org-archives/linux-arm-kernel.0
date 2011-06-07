From: davej@redhat.com (Dave Jones)
Date: Mon, 6 Jun 2011 22:09:15 -0400
Subject: [PATCH] [CPUFREQ] s5pv210-cpufreq.c: Add missing clk_put
In-Reply-To: <1307411942-20711-1-git-send-email-kgene.kim@samsung.com>
References: <1307411942-20711-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20110607020915.GB25438@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2011 at 06:59:02PM -0700, Kukjin Kim wrote:

 > Hi Dave,
 > 
 > Could you please pick this up in your tree?
 > 
 >  drivers/cpufreq/s5pv210-cpufreq.c |   25 +++++++++++++++++--------
 >  1 files changed, 17 insertions(+), 8 deletions(-)

applied and pushed, thanks.

	Dave

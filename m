From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 16 Sep 2010 09:33:18 +0900
Subject: [PATCH 0/5] ARM: S5PV210: Add support CPUFREQ for S5PV210/S5PC110
In-Reply-To: <1284537162-3129-1-git-send-email-jc.lee@samsung.com>
References: <1284537162-3129-1-git-send-email-jc.lee@samsung.com>
Message-ID: <AANLkTikB288=Y8_jMXCwfsEBqwRdOTKyjMJag=SCKYdP@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First thank you for posting the patches.
but I'm worry about sending the same feature patches from different divisions.

I'm not sure you're talking with kgene. but there are some codes
posted by Mr. Ham and get feedback and reviewed with kgene.
http://git.infradead.org/users/kmpark/linux-2.6-samsung/shortlog/refs/heads/cpufreq

To kgene,
One code from DMC(me), another code from System LSI(you). then which
codes do you pick up and apply to mainline?
and what's rules or principles?

Thank you,
Kyungmin Park

On Wed, Sep 15, 2010 at 4:52 PM, Jaecheol Lee <jc.lee@samsung.com> wrote:
> This patch adds CPUFREQ for S5PV210/S5PC110.
>
> [PATCH 1/5] ARM: S5PV210: Add support DMC map_desc table
> [PATCH 2/5] ARM: S5PV210: Add struct clk_ops for clk_fout_apll
> [PATCH 3/5] ARM: S5PV210: Add Register definition for CMU
> [PATCH 4/5] ARM: S5PV210: Add support CPUFREQ
> [PATCH 5/5] ARM: S5PV210: Update Kconfig and Makefile for supporting CPUFREQ driver
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>

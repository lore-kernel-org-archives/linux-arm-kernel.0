From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Feb 2013 15:56:26 -0800
Subject: [PATCH 1/2] ARM: OMAP2+: SoC name and revision unification
In-Reply-To: <1359660284-5225-2-git-send-email-ruslan.bilovol@ti.com>
References: <1359660284-5225-1-git-send-email-ruslan.bilovol@ti.com>
 <1359660284-5225-2-git-send-email-ruslan.bilovol@ti.com>
Message-ID: <20130205235626.GS25185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ruslan Bilovol <ruslan.bilovol@ti.com> [130131 11:28]:
> This is a long story where for each new generation of
> OMAP we used different approaches for creating
> strings for SoCs names and revisions that this patch
> fixes. It makes future exporting of this information
> to SoC infrastructure easier.

Maybe use name soc_name and soc_rev instead and make
cpu_name and cpu_rev local to the functions?
That would reduce some churn here.

Also this does not apply to my omap-for-v3.9/soc
branch. Care to update this (and possibly the second one)
against that?

Regards,

Tony

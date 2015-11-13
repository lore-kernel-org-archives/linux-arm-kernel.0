From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Nov 2015 10:32:45 +0530
Subject: [PATCH v3 1/2] thermal: mediatek: Add cpu power cooling model.
In-Reply-To: <20151110112017.GA3551@e104805>
References: <1445515359-8587-1-git-send-email-dawei.chien@mediatek.com>
 <1445515359-8587-2-git-send-email-dawei.chien@mediatek.com>
 <20151104193958.GC14127@localhost.localdomain>
 <1446721837.4016.57.camel@mtksdaap41>
 <20151106032433.GL3773@ubuntu> <20151110112017.GA3551@e104805>
Message-ID: <20151113050245.GD3576@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10-11-15, 11:20, Javi Merino wrote:
> The way they are described here is useful only for this platform, but
> it's not generic.  It only takes into account voltage as (I assume)
> it's the only variable that affects it in this implementation.  A
> generalized version of the static power should take into account the
> temperature and the idle state.

yeah, but I thought we are talking about the final static power being
present in the DT. How the platform gets it, doesn't matter at all.
They may consider just the voltage or temperature and idle state as
well.

-- 
viresh

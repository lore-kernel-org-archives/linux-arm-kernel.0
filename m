From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 23 Dec 2015 10:48:24 +0000
Subject: [PATCH] cpufreq/scpi: fix handling return value of
 topology_physical_package_id
In-Reply-To: <1450867041-729-1-git-send-email-a.hajda@samsung.com>
References: <1450867041-729-1-git-send-email-a.hajda@samsung.com>
Message-ID: <567A7BF8.1030107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/12/15 10:37, Andrzej Hajda wrote:
> The function can return negative values, so its result should
> be assigned to signed variable.
>
> The problem has been detected using proposed semantic patch
> scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].
>
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2038576
>

There has a patch posted by Dan Carpenter [1] which I reposted[2],
but it again slipped through the cracks. I will poke Rafael again on that.

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/380292.html
[2] https://lkml.org/lkml/2015/12/15/219

-- 
Regards,
Sudeep

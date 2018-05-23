From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 23 May 2018 17:59:31 +0100
Subject: [PATCH] firmware: arm_scmi: remove some unnecessary checks
In-Reply-To: <20180519063715.GB4991@mwanda>
References: <20180519063715.GB4991@mwanda>
Message-ID: <a71e8503-0da0-6d5d-83e1-667d7768bfd4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/05/18 07:37, Dan Carpenter wrote:
> The "pi->dom_info" buffer is allocated in init() and it can't be NULL
> here.  These tests are sort of weird as well because if "pi->dom_info"
> was NULL but "domain" was non-zero then it would lead to an Oops.
>

Indeed. Thanks for the patch.

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.

-- 
Regards,
Sudeep

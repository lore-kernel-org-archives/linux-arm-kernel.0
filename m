From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 16 Nov 2016 14:34:28 +0000
Subject: [PATCH 08/16] ARM: vexpress: use generic API for enabling SCU
In-Reply-To: <1479099731-28108-9-git-send-email-pankaj.dubey@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <1479099731-28108-9-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <c6cb4dbd-847e-832a-894b-bf8718248538@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/11/16 05:02, Pankaj Dubey wrote:
> Now as we have of_scu_enable which takes care of mapping
> scu base from DT, lets use it.
>
> CC: Liviu Dudau <liviu.dudau@arm.com>
> CC: Sudeep Holla <sudeep.holla@arm.com>

I assume you will take this series through a single tree. Also I assume
you may make changes around a9 SCU. I will try to test if I can get my
setup back working. But if this patch is not changed, then

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

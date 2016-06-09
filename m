From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 9 Jun 2016 12:12:37 +0100
Subject: [PATCH] power: vexpress: make dev_attr_active static
In-Reply-To: <1465410391-29475-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465410391-29475-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <57594F25.4010307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/06/16 19:26, Ben Dooks wrote:
> The dev_attr_active is not exported or defined to be used
> outside the driver, so make it static to avoid the following
> warning:
>
> drivers/power/reset/vexpress-poweroff.c:77:1: warning: symbol 'dev_attr_active' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Pulled into vexpress-for-v4.8/fixes[1] along with other 3 vexpress
related patches. Thanks.

-- 
Regards,
Sudeep

[1] git.kernel.org/sudeep.holla/linux/h/vexpress-for-v4.8/fixes

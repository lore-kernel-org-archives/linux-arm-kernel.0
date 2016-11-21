From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 21 Nov 2016 16:30:41 +0000
Subject: [PATCH] PM / Domains: Fix compatible for domain idle state
In-Reply-To: <1478210075-92045-2-git-send-email-lina.iyer@linaro.org>
References: <1478210075-92045-1-git-send-email-lina.iyer@linaro.org>
 <1478210075-92045-2-git-send-email-lina.iyer@linaro.org>
Message-ID: <bb7451ec-6bc3-aa95-2334-fbaeb492e457@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lina,

On 03/11/16 21:54, Lina Iyer wrote:
> Re-using idle state definition provided by arm,idle-state for domain
> idle states creates a lot of confusion and limits further evolution of
> the domain idle definition. To keep things clear and simple, define a
> idle states for domain using a new compatible "domain-idle-state".
>
> Fix existing PM domains code to look for the newly defined compatible.
>

Thanks for doing this(reluctantly? :-)). Looks good to me.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

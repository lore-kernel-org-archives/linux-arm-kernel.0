From: julien.grall@arm.com (Julien Grall)
Date: Wed, 6 Apr 2016 12:40:59 +0100
Subject: [PATCH v10 02/17] xen/grant-table: Move xlated_setup_gnttab_pages
 to common place
In-Reply-To: <1459525755-36968-3-git-send-email-shannon.zhao@linaro.org>
References: <1459525755-36968-1-git-send-email-shannon.zhao@linaro.org>
 <1459525755-36968-3-git-send-email-shannon.zhao@linaro.org>
Message-ID: <5704F5CB.8070500@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 01/04/2016 16:49, Shannon Zhao wrote:
> Move xlated_setup_gnttab_pages to common place, so it can be reused by
> ARM to setup grant table.
>
> Rename it to xen_xlate_map_ballooned_pages.
>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Reviewed-by: Julien Grall <julien.grall@arm.com>

Regards,

-- 
Julien Grall

From: julien.grall@arm.com (Julien Grall)
Date: Wed, 6 Apr 2016 12:42:04 +0100
Subject: [PATCH v10 03/17] Xen: xlate: Use page_to_xen_pfn instead of
 page_to_pfn
In-Reply-To: <1459525755-36968-4-git-send-email-shannon.zhao@linaro.org>
References: <1459525755-36968-1-git-send-email-shannon.zhao@linaro.org>
 <1459525755-36968-4-git-send-email-shannon.zhao@linaro.org>
Message-ID: <5704F60C.4040002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 01/04/2016 16:49, Shannon Zhao wrote:
> Make xen_xlate_map_ballooned_pages work with 64K pages. In that case
> Kernel pages are 64K in size but Xen pages remain 4K in size. Xen pfns
> refer to 4K pages.
>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Reviewed-by: Julien Grall <julien.grall@arm.com>

Regards,

-- 
Julien Grall

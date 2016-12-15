From: julien.grall@arm.com (Julien Grall)
Date: Thu, 15 Dec 2016 11:41:12 +0000
Subject: [PATCH v2 2/4] Xen: Support adding DT nodes
In-Reply-To: <20161122150917.16524-3-andre.przywara@arm.com>
References: <20161122150917.16524-1-andre.przywara@arm.com>
 <20161122150917.16524-3-andre.przywara@arm.com>
Message-ID: <a83a030f-e643-4f92-19af-06fce19ebb9d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On 22/11/16 15:09, Andre Przywara wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
>
> Support adding xen,xen-bootargs node via --with-xen-bootargs to the

Based the code, the configure option is --with-xen-cmdline.

> configure script and automatically add the Dom0 node to the DT as well.
>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

With the above request:

Reviewed-by: Julien Grall <julien.grall@arm.com>

Regards,

-- 
Julien Grall

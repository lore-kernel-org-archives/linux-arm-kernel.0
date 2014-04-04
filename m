From: julien.grall@linaro.org (Julien Grall)
Date: Fri, 04 Apr 2014 12:50:44 +0100
Subject: [PATCH] Xen: do hv callback accounting only on x86
In-Reply-To: <533E9A75.4050102@linaro.org>
References: <5057041.71iuvlcH4G@wuerfel> <12121341.4lKFpaRMcO@wuerfel>
 <533E9A75.4050102@linaro.org>
Message-ID: <533E9C94.5040902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2014 12:41 PM, Julien Grall wrote:
> Linus has merged xen/tip yesterday and building ARM with CONFIG_XEN=y is
> now broken.

My mistake, it's not because of xen/tip, but some other branches.

-- 
Julien Grall

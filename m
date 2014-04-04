From: david.vrabel@citrix.com (David Vrabel)
Date: Fri, 4 Apr 2014 13:15:12 +0100
Subject: [PATCH] Xen: do hv callback accounting only on x86
In-Reply-To: <533E9A75.4050102@linaro.org>
References: <5057041.71iuvlcH4G@wuerfel> <12121341.4lKFpaRMcO@wuerfel>
 <533E9A75.4050102@linaro.org>
Message-ID: <533EA250.90709@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/14 12:41, Julien Grall wrote:
> 
> Linus has merged xen/tip yesterday and building ARM with CONFIG_XEN=y is
> now broken.

Sorry, I couldn't add this patch to the xen tree at the time since the
change was on a different tree and then I forgot about it.

Now applied to devel/for-linus-3.15.

David

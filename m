From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 4 Jun 2014 15:16:03 +0200
Subject: [PATCH v2] arm/arm64: KVM: Fix and refactor unmap_range
In-Reply-To: <080001cf7e3c$646ebc30$2d4c3490$@samsung.com>
References: <1401286977-59260-1-git-send-email-christoffer.dall@linaro.org>
 <080001cf7e3c$646ebc30$2d4c3490$@samsung.com>
Message-ID: <20140604131603.GC19587@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 02, 2014 at 05:26:46PM +0900, Jungseok Lee wrote:
> On Wednesday, May 28, 2014 11:23 PM, Christoffer Dall wrote:
[...]
> 
> This is a pretty good idea. It helps to accommodate different translation
> level options supported by ARMv8.
> 
> It looks reasonable to me:
> 
> Reviewed-by: Jungseok Lee <jays.lee@samsung.com>
> 

Thanks!

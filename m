From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 11 Oct 2017 12:16:50 -0700
Subject: [PATCH 05/11] Disable kasan's instrumentation
In-Reply-To: <20171011082227.20546-6-liuwenliang@huawei.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-6-liuwenliang@huawei.com>
Message-ID: <cf3776c0-b6e0-7a6e-9d43-d77ddd83749b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2017 01:22 AM, Abbott Liu wrote:
> From: Andrey Ryabinin <a.ryabinin@samsung.com>
> 
>  To avoid some build and runtime errors, compiler's instrumentation must
>  be disabled for code not linked with kernel image.
> 
> Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
> Signed-off-by: Abbott Liu <liuwenliang@huawei.com>

Same as patch 3, this needs to be moved before you allow KAsan to be
enabled/selected. This has little to no dependencies on other patches so
this could be moved as the first patch in the series.

Thanks!
-- 
Florian

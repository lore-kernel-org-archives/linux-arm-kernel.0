From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 11 Oct 2017 12:15:44 -0700
Subject: [PATCH 03/11] arm: Kconfig: enable KASan
In-Reply-To: <20171011082227.20546-4-liuwenliang@huawei.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-4-liuwenliang@huawei.com>
Message-ID: <a3902e32-0141-9616-ba3e-9cbbd396b99a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2017 01:22 AM, Abbott Liu wrote:
> From: Andrey Ryabinin <a.ryabinin@samsung.com>
> 
> This patch enable kernel address sanitizer for arm.
> 
> Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
> Signed-off-by: Abbott Liu <liuwenliang@huawei.com>

This needs to be the last patch in the series, otherwise you allow
people between patch 3 and 11 to have varying degrees of experience with
this patch series depending on their system type (LPAE or not, etc.)
-- 
Florian

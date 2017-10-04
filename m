From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 4 Oct 2017 19:59:39 +0200
Subject: [PATCH 1/6] ARM: s3c24xx: Delete an error message for a failed
 memory allocation in s3c2410_iotiming_get()
In-Reply-To: <1207a56d-3fa6-9c80-d9fe-4b56b11ff0a7@users.sourceforge.net>
References: <d2ae00c8-da57-9ffc-3692-67ed6daa95e0@users.sourceforge.net>
 <1207a56d-3fa6-9c80-d9fe-4b56b11ff0a7@users.sourceforge.net>
Message-ID: <20171004175939.ofotquvf52quvgbo@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 02, 2017 at 07:58:02PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 2 Oct 2017 19:14:20 +0200
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/arm/mach-s3c24xx/iotiming-s3c2410.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof

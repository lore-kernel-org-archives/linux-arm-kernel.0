From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Fri, 16 Feb 2018 10:41:51 +0200
Subject: [PATCH] crypto: atmel: Delete error messages for a failed memory
 allocation in six functions
In-Reply-To: <77cf1006-966d-78a9-0fdc-b53ccdd80df2@users.sourceforge.net>
References: <77cf1006-966d-78a9-0fdc-b53ccdd80df2@users.sourceforge.net>
Message-ID: <285d8666-5992-cccb-6c91-e83e85947a7d@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/15/2018 02:24 PM, SF Markus Elfring wrote:
> From: Markus Elfring<elfring@users.sourceforge.net>
> Date: Thu, 15 Feb 2018 11:38:30 +0100
> 
> Omit extra messages for a memory allocation failure in these functions.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring<elfring@users.sourceforge.net>

Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

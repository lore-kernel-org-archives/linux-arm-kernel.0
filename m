From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 2 Feb 2018 11:24:47 -0600
Subject: [PATCH 0/2] I2C-DaVinci: Adjustments for davinci_i2c_probe()
In-Reply-To: <4e668c87-65f5-8a00-132a-0184779faa08@users.sourceforge.net>
References: <4e668c87-65f5-8a00-132a-0184779faa08@users.sourceforge.net>
Message-ID: <310d5f2c-3a8d-80e3-a185-21da933d107f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/02/2018 11:20 AM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 2 Feb 2018 18:16:14 +0100
> 
> Two update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>    Delete an error message for a failed memory allocation
>    Improve a size determination
> 
>   drivers/i2c/busses/i2c-davinci.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii

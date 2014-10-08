From: sbranden@broadcom.com (Scott Branden)
Date: Wed, 8 Oct 2014 04:01:06 -0700
Subject: [PATCH 4/6] ARM: cygnus defconfig : Initial defconfig for Broadcom
 Cygnus SoC
In-Reply-To: <1996601.jhvNxNYxnl@wuerfel>
References: <1412746025-11998-5-git-send-email-sbranden@broadcom.com>
 <1996601.jhvNxNYxnl@wuerfel>
Message-ID: <54351972.5030803@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-10-08 12:58 AM, Arnd Bergmann wrote:
> On Tuesday 07 October 2014 22:27:03 Scott Branden wrote:
>> From: Jonathan Richardson <jonathar@broadcom.com>
>>
>> Tested-by: Jonathan Richardson <jonathar@broadcom.com>
>> Reviewed-by: JD (Jiandong) Zheng <jdzheng@broadcom.com>
>> Signed-off-by: Scott Branden <sbranden@broadcom.com>
>
> Do you actually need a separate defconfig?
>
> If possible, just add your drivers to multi_v7_defconfig, otherwise
> include a justification in the patch changelog why your platform
> should have its own defconfig file.
We need a separate defconfig so that customers and developers have some 
chance of understanding what kernel drivers apply to their SoC.  That 
way they can optimize kernel size if desired.  Will update patch 
changelog in next version.
>
> 	Arnd
>

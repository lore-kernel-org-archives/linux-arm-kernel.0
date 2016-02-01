From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 01 Feb 2016 13:11:36 -0800
Subject: [PATCH] ARM: bcm: use const and __initconst for smp_operations
In-Reply-To: <56A65841.1040100@broadcom.com>
References: <1453721475-15156-1-git-send-email-yamada.masahiro@socionext.com>
 <56A65841.1040100@broadcom.com>
Message-ID: <56AFCA08.60903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/01/16 09:15, Ray Jui wrote:
> Hi Masahiro,
> 
> On 1/25/2016 3:31 AM, Masahiro Yamada wrote:
>> This newly added code missed the global fixup by commit 75305275a721
>> ("ARM: use const and __initconst for smp_operations").  So fix it now.
>>
>> Also, add missing "static" qualifier.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied, thanks!
-- 
Florian

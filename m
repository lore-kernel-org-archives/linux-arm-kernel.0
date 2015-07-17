From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 17 Jul 2015 11:19:26 +0200
Subject: [PATCH v2 2/4] mfd: max77686: Use a generic name for the PMIC
 node in the example
In-Reply-To: <55A8C6B2.5020109@cogentembedded.com>
References: <1437114567-17629-1-git-send-email-javier@osg.samsung.com>
 <1437114567-17629-3-git-send-email-javier@osg.samsung.com>
 <55A8C6B2.5020109@cogentembedded.com>
Message-ID: <55A8C89E.8010606@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sergei,

On 07/17/2015 11:11 AM, Sergei Shtylyov wrote:
> Hello.
> 
> On 7/17/2015 9:29 AM, Javier Martinez Canillas wrote:
> 
>> The ePAR standard says that: "the name of a node should be somewhat
> 
>    ePAPR.
>

Thanks for pointing it out. I guess that Lee can fix the typo when applying?

>> generic, reflecting the function of the device and not its precise
>> programming model."
> 
>> So, change the max77686 binding document example to use a generic
>> node name instead of using the chip's name.
> 
>> Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> MBR, Sergei
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

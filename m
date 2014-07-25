From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 25 Jul 2014 13:00:49 +0200
Subject: [PATCH v7 3/4] ARM: EXYNOS: Add platform driver support for Exynos
 PMU
In-Reply-To: <000501cfa7c9$e59f4840$b0ddd8c0$@samsung.com>
References: <1404878455-31518-1-git-send-email-pankaj.dubey@samsung.com>
 <1404878455-31518-4-git-send-email-pankaj.dubey@samsung.com>
 <067501cfa7bd$8e6cb460$ab461d20$@samsung.com>
 <000501cfa7c9$e59f4840$b0ddd8c0$@samsung.com>
Message-ID: <53D238E1.3030901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj, Kukjin,

On 25.07.2014 07:32, Pankaj Dubey wrote:
> Hi Kukjin,
> 
> On Friday, July 25, 2014 Kukjin Kim wrote:

[snip]

>>>
>> Looks good to me, will apply this and 4/4.
>>
> 
> We need to hold these two patches until dependent patch [1] from Tomasz Figa
> gets merged.
> 
> [1]: mfd: syscon: Decouple syscon interface from syscon devices
>       https://lkml.org/lkml/2014/6/24/188

That RFC patch had few comments from Arnd needed to be addressed, so it
needs a new revision.

Pankaj, If I remember correctly, we had talked about this and the
conclusion was that you would take care of addressing the comments and
sending new version of the patch. Any update on this or have I missed
something?

Best regards,
Tomasz

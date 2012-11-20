From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue, 20 Nov 2012 08:56:06 +0530
Subject: [PATCH] ARM: gic: Fix sparse warning
In-Reply-To: <50AA293C.9010908@mvista.com>
References: <1353322736-2747-1-git-send-email-tushar.behera@linaro.org>
 <50AA293C.9010908@mvista.com>
Message-ID: <50AAF84E.5080900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2012 06:12 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 19-11-2012 14:58, Tushar Behera wrote:
> 
>> gic_irq_domain_ops is only used in this file, so should be marked as
>> static.
> 
>> Fixes following compilation warning.
> 
>   This is sparse's warning, not compiler's, if I don't mistake.
> 

My mistake. It is indeed sparse warning.

>> arch/arm/common/gic.c:638:29: warning: symbol 'gic_irq_domain_ops' was
>> not declared. Should it be static?
> 
>> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> 
> WBR, Sergei
> 
> 


-- 
Tushar Behera

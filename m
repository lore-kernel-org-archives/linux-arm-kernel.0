From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 01 Aug 2012 09:19:34 +0100
Subject: [PATCH 3/6] ARM: ux500: Fix merge error,
 so such struct 'snd_soc_u8500'
In-Reply-To: <5018DC9F.30502@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-6-git-send-email-lee.jones@linaro.org>
 <50180BF6.6080908@mvista.com> <5018DC9F.30502@linaro.org>
Message-ID: <5018E696.9000305@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/12 08:37, Lee Jones wrote:
> On 31/07/12 17:46, Sergei Shtylyov wrote:
>> Hello.
>>
>> On 07/31/2012 05:31 PM, Lee Jones wrote:
>>
>>     Subject doesn't parse for me...
>>
>>> The platform attempts to register platform device 'snd_soc_u8500'
>>> which doesn't actually exist. Here we change the reference to the
>>> correct one 'snd_soc_mop500'.
>>
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
> Actually, it does make sense?
>
> As a sentence: "This patch fixes merge error: so such structure 'struct snd_soc_u8500'.

That's interesting. Not only when I read it did it seem correct, I also 
wrote it wrong "as a sentence". Of course "so" should be "no".


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

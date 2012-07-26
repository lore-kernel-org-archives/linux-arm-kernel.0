From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 26 Jul 2012 14:52:09 +0100
Subject: [PATCH 17/21] ASoC: Ux500: Enable ux500 PCM driver for Device Tree
In-Reply-To: <20120726113838.GA3099@opensource.wolfsonmicro.com>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-18-git-send-email-lee.jones@linaro.org>
 <20120726113838.GA3099@opensource.wolfsonmicro.com>
Message-ID: <50114B89.7070100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/07/12 12:38, Mark Brown wrote:
> On Thu, Jul 26, 2012 at 11:28:50AM +0100, Lee Jones wrote:
>
>> Here we pass platform registration from platform code over to Device
>> Tree, when DT is enabled.
>
>> -	pr_info("%s: Register platform-device 'ux500-pcm'\n", __func__);
>> -	platform_device_register(&ux500_pcm);
>
> This has the same issue as your last patch...  the way you're doing
> things will break audio on all boards using this driver.

It will, why?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

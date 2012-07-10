From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 10 Jul 2012 12:35:35 +0530
Subject: [PATCH v1 01/11] drivers: usb: otg: add a new driver for omap
 usb2 phy
In-Reply-To: <CAAe_U6Kx8o6sHgpev3UEAou7tuNDt9iL0+hcyOVDb0WsCsSwKg@mail.gmail.com>
References: <1340884267-28908-1-git-send-email-kishon@ti.com>	<1340884267-28908-2-git-send-email-kishon@ti.com>	<4FFBC1D0.5030506@ti.com>	<D958900912E20642BCBC71664EFECE3E6DDAD9FF96@BGMAIL02.nvidia.com>
 <CAAe_U6Kx8o6sHgpev3UEAou7tuNDt9iL0+hcyOVDb0WsCsSwKg@mail.gmail.com>
Message-ID: <4FFBD43F.4010704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 July 2012 12:18 PM, ABRAHAM, KISHON VIJAY wrote:
> Hi,
>
> On Tue, Jul 10, 2012 at 11:33 AM, Venu Byravarasu
> <vbyravarasu@nvidia.com>  wrote:
>>>> +
>>>> +#ifdef CONFIG_PM
>>
>> Should it not be CONFIG_PM_SLEEP instead of just CONFIG_PM?
>
> Why? I think we should have CONFIG_PM_SLEEP only when we have
> *suspend*, *resume* hooks. But this driver has only *runtime_suspend*
> and *runtime_resume* hooks.

CONFIG_PM_RUNTIME maybe then?

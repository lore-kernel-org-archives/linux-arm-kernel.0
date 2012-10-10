From: jason77.wang@gmail.com (Hui Wang)
Date: Wed, 10 Oct 2012 11:26:52 +0800
Subject: [PATCH v4 1/3] Input: egalax_ts: get gpio from devicetree node
In-Reply-To: <201210091158.33040.arnd@arndb.de>
References: <1345114051-3052-1-git-send-email-jason77.wang@gmail.com>
 <1345114051-3052-2-git-send-email-jason77.wang@gmail.com>
 <20120817003125.GA24242@S2101-09.ap.freescale.net>
 <201210091158.33040.arnd@arndb.de>
Message-ID: <5074EAFC.1010409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> On Friday 17 August 2012, Shawn Guo wrote:
>   
>> On Thu, Aug 16, 2012 at 06:47:29PM +0800, Hui Wang wrote:
>>     
>>> The irq_to_gpio() is old, most platforms use GENERIC_GPIO framework
>>> and don't support this API anymore.
>>>
>>> The i.MX6q sabrelite platform equips an egalax touchscreen controller,
>>> and this platform already transfered to GENERIC_GPIO framework, to
>>> support this driver, we use a more generic way to get gpio.
>>>
>>> Add a return value checking for waking up the controller in the probe
>>> function, this guarantee only a workable device can pass init.
>>>
>>> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
>>>       
>> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
>>     
>
> What's the status on this patch? I'm still getting build errors from this
> driver, so I guess it was never accepted for the 3.7 merge window.
>
> 	Arnd
>
>   
I forgot to resend this patchset After Dmitry was back to the maillist. 
I will rebase the patchset and resend them to review.

Regards,
Hui.

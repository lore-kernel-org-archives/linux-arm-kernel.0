From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Fri, 29 May 2015 15:40:31 +0530
Subject: [PATCH 2/3] tty: serial: fsl_lpuart: remove RTS/CTS control from
 set/get_mctrl
In-Reply-To: <20150529120421.754fd6ab@north>
References: <1432886754-30115-1-git-send-email-bhuvanchandra.dv@toradex.com>	<1432886754-30115-3-git-send-email-bhuvanchandra.dv@toradex.com>
 <20150529120421.754fd6ab@north>
Message-ID: <55683B17.1010706@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jakub,

On 05/29/2015 03:34 PM, Jakub Kici?ski wrote:
> On Fri, 29 May 2015 13:35:53 +0530, Bhuvanchandra DV wrote:
>> The LPUART does not provide manual control of RTS/CTS signals,
>> those can only be controlled by the hardware directly. Therefore
>> manual control of those signals through mctrl can not be provided.
>> The current implementation enables/disables the automatic control,
>> which is not what mctrl should do, hence remove the incorrect
>> implementation.
>>
>> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
>
> Now that the functions do nothing there is probably no point in keeping
> separate lpuart/lpuart32 variants.
Agreed, will update it accordingly.

Thanks! for pointing this.
>

Best regards,
Bhuvan

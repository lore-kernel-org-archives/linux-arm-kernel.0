From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 18 Dec 2013 09:21:12 +0800
Subject: [PATCH v9 0/2] PWM: pwm-atmel: add PWM controller driver
In-Reply-To: <20131217103034.GE13823@ulmo.nvidia.com>
References: <1386916910-24832-1-git-send-email-voice.shen@atmel.com>
 <20131217103034.GE13823@ulmo.nvidia.com>
Message-ID: <52B0F888.2000905@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On 12/17/2013 06:30 PM, Thierry Reding wrote:
> On Fri, Dec 13, 2013 at 02:41:48PM +0800, Bo Shen wrote:
>> This patch series add Atmel PWM controller driver support.
>>
>> Changes in v9:
>>    - Address the comments from Thierry Reding
>
> Hi,
>
> I've pushed a slightly modified version of this series. There were a few
> minor whitespace/coding style issues, but perhaps more importantly I've
> modified the period change check to be done earlier and in a more
> generic way.

Thanks for your work.

> Can you please check that the version I've pushed to the for-next branch
> still works for you?

Tested OK with pwm leds and pwm backlight.
Thanks again.

> Thanks,
> Thierry

Best Regards,
Bo Shen

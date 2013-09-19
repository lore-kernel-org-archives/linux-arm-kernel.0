From: b.brezillon@overkiz.com (boris brezillon)
Date: Thu, 19 Sep 2013 14:11:01 +0200
Subject: [PATCH 0/2] pwm: atmel-tcb: config fixes
In-Reply-To: <20130919120616.GG10852@ulmo>
References: <1379516720-23289-1-git-send-email-b.brezillon@overkiz.com>
 <20130919120616.GG10852@ulmo>
Message-ID: <523AE9D5.6040103@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/09/2013 14:06, Thierry Reding wrote:
> On Wed, Sep 18, 2013 at 05:05:20PM +0200, Boris BREZILLON wrote:
>> Hello,
>>
>> This patch series fix 2 bugs regarding the pwm configuration:
>>   - the clock source of the timer channel is never applied
>>   - the maximum time that can be represented when using the slow clock may be
>>     wrong if the tc block provide a 32 bits width counter
>>
>> Best Regards,
>>
>> Boris
>>
>> Boris BREZILLON (2):
>>    pwm: atmel-tcb: add missing clk source config
>>    pwm: atmel-tcb: fix max time computation for slow clk source
>>
>>   drivers/pwm/pwm-atmel-tcb.c |    4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
> Both applied, with Nicolas' Acked-by.
>
> Thierry
Thanks.

Regards,
Boris

From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 19 Jun 2013 09:00:02 +0800
Subject: [PATCH v3 1/2] i2c: designware: use module_platform_driver
In-Reply-To: <20130618162711.GG7718@katana>
References: <1370918230-24793-1-git-send-email-zhangfei.gao@linaro.org>
 <1370918230-24793-2-git-send-email-zhangfei.gao@linaro.org>
 <20130618162711.GG7718@katana>
Message-ID: <51C10292.9000906@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-06-19 12:27 AM, Wolfram Sang wrote:
> On Tue, Jun 11, 2013 at 10:37:09AM +0800, Zhangfei Gao wrote:
>> Instead of use platform_driver_probe, use module_platform_driver
>> To support deferred probing
>> Also subsys_initcall may too early to auto set pinctl
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> CC: Baruch Siach <baruch@tkos.co.il>
>
> Basically OK, but please resend for 3.12, so we get enough testing
> before entering mainline. I am a bit anxious of side
> effects and 3.11 is too near.
>

Dear Wolfram,

Sorry for the silly question: How to be prepared for 3.12?

Do you mean there is specific git & branch, which I should rebase on?
linux-next.git is what I use now.

Thanks

From: rob.lee@linaro.org (Rob Lee)
Date: Wed, 2 May 2012 09:09:12 -0500
Subject: [PATCH v2 1/3] ARM: imx: Add common imx cpuidle init
 functionality.
In-Reply-To: <CAAQ0ZWTsdNE7=c8CxPGbqdUKYp5wHa1yVriv2OApEFAqtm43Pg@mail.gmail.com>
References: <1335924760-796-1-git-send-email-rob.lee@linaro.org>
 <1335924760-796-2-git-send-email-rob.lee@linaro.org>
 <20120502031311.GT2194@S2101-09.ap.freescale.net>
 <CAMXH7KG9DNm4Yv4-YMHdB5-aZ14VKVhnHkwEZVUWpjO9q6Vp8w@mail.gmail.com>
 <CAAQ0ZWTsdNE7=c8CxPGbqdUKYp5wHa1yVriv2OApEFAqtm43Pg@mail.gmail.com>
Message-ID: <CAMXH7KGcFjEXazVJeEmKA+7s2yPJv6tzsrPg0d=SwtgH3A62fQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2012 at 9:07 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On 2 May 2012 21:59, Rob Lee <rob.lee@linaro.org> wrote:
>>>> + ? ? ? ? ? ? ret = cpuidle_register_device(dev);
>>>> + ? ? ? ? ? ? if (ret) {
>>>> + ? ? ? ? ? ? ? ? ? ? pr_err("%s: Failed to register cpu %u\n",
>>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? __func__, cpu_id);
>>>
>>> Nit: print ret (error code) too?
>>>
>>
>> I added the printing of the error code based on Sascha's suggestion in
>> v1 of this submission.
>>
> But you did not print "ret" in above pr_err.
>

Argh, sorry, still trying to wake up I guess.  Thanks.

> Regards,
> Shawn

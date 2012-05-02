From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 2 May 2012 22:07:20 +0800
Subject: [PATCH v2 1/3] ARM: imx: Add common imx cpuidle init
 functionality.
In-Reply-To: <CAMXH7KG9DNm4Yv4-YMHdB5-aZ14VKVhnHkwEZVUWpjO9q6Vp8w@mail.gmail.com>
References: <1335924760-796-1-git-send-email-rob.lee@linaro.org>
 <1335924760-796-2-git-send-email-rob.lee@linaro.org>
 <20120502031311.GT2194@S2101-09.ap.freescale.net>
 <CAMXH7KG9DNm4Yv4-YMHdB5-aZ14VKVhnHkwEZVUWpjO9q6Vp8w@mail.gmail.com>
Message-ID: <CAAQ0ZWTsdNE7=c8CxPGbqdUKYp5wHa1yVriv2OApEFAqtm43Pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 May 2012 21:59, Rob Lee <rob.lee@linaro.org> wrote:
>>> + ? ? ? ? ? ? ret = cpuidle_register_device(dev);
>>> + ? ? ? ? ? ? if (ret) {
>>> + ? ? ? ? ? ? ? ? ? ? pr_err("%s: Failed to register cpu %u\n",
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? __func__, cpu_id);
>>
>> Nit: print ret (error code) too?
>>
>
> I added the printing of the error code based on Sascha's suggestion in
> v1 of this submission.
>
But you did not print "ret" in above pr_err.

Regards,
Shawn

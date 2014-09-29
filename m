From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 29 Sep 2014 12:27:58 +0100
Subject: [PATCH 3/4] ARM: DT: apq8064: Add USB OTG support
In-Reply-To: <20140929105329.GA2432@leverpostej>
References: <1411982044-7873-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1411982127-8048-1-git-send-email-srinivas.kandagatla@linaro.org>
 <542933E1.8010809@smartplayin.com> <20140929105329.GA2432@leverpostej>
Message-ID: <5429423E.8030908@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/09/14 11:53, Mark Rutland wrote:
>> >Its canonical value is "okay" (although in practice anything
>> >other than "disabled" should work).
> That's not quite true, there are other "bad" values like "fail" and
> "fail-sss" documented by ePAPR. In Linux, of_device_is_available errs on
> the side of caution and checks for either "okay" or "ok", failing
> otherwise
>
> Regardless, please use the canonical "okay".
I will fix this in v2.


--srini

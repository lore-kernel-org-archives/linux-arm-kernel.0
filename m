From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 29 Jul 2014 18:43:27 +0800
Subject: [PATCH v15 08/12] ARM: config: append lpae configuration
In-Reply-To: <20140729040531.GB8430@quad.lixom.net>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <1406555876-11989-9-git-send-email-haojian.zhuang@linaro.org>
 <20140729040531.GB8430@quad.lixom.net>
Message-ID: <CAD6h2NQ-+t0=XvMWR54tzpvkMe+JT4FcLvQFPNJuUea32GDS8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 July 2014 12:05, Olof Johansson <olof@lixom.net> wrote:
> On Mon, Jul 28, 2014 at 09:57:52PM +0800, Haojian Zhuang wrote:
>> Append multi_v7_lpae_config. In this default configuration,
>> CONFIG_ARCH_MULTI_V6 is disabled. CONFIG_ARM_LPAE is enabled.
>
> NACK. This is the nth time I have had to nack this patch.
>
> You are enabling platforms here that don't have LPAE. Don't do that.
>
> It's trivial to create a LPAE version of multi_v7 defconfig locally.
>
>
> -Olof

I tried to remove those SoCs that can't support LPAE. But I don't know
every platform in details.

How about that I only enable HIP04 in multi_v7_lpae_defconfig. If you
think any platform could be added, please help to list it. Then I
could append them into the multi_v7_lpae_defconfig.

Regards
Haojian

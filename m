From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 9 May 2014 14:35:58 +0800
Subject: [PATCH v5 10/14] ARM: config: append hip04_defconfig
In-Reply-To: <20140507165241.GD12692@quad.lixom.net>
References: <1399473888-12947-1-git-send-email-haojian.zhuang@linaro.org>
 <1399473888-12947-11-git-send-email-haojian.zhuang@linaro.org>
 <20140507165241.GD12692@quad.lixom.net>
Message-ID: <CAD6h2NR_Gu-dW2ZpwJy=dRri-uZaULxu9PeOq6PBsCd5P__8-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 May 2014 00:52, Olof Johansson <olof@lixom.net> wrote:
> On Wed, May 07, 2014 at 10:44:44PM +0800, Haojian Zhuang wrote:
>> Select HiP04 SoC configuration by hip04_defconfig.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>
> We're letting each vendor have one defconfig. This should coexist and/or add to
> the hi3xxx defconfig instead of creating a new one.
>
>
> -Olof

In HiP04, I need to enable 16 CPUs & LPAE.

16 CPU are specified by CONFIG_NR_CPUS. And Hi3xxx SoC don't need LPAE.

Regards
Haojian

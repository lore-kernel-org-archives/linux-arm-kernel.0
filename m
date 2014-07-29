From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 29 Jul 2014 18:41:06 +0800
Subject: [PATCH v15 10/12] ARM: hisi: enable erratum 798181 of A15 on HiP04
In-Reply-To: <20140729040837.GD8430@quad.lixom.net>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <1406555876-11989-11-git-send-email-haojian.zhuang@linaro.org>
 <20140729040837.GD8430@quad.lixom.net>
Message-ID: <CAD6h2NR0vK4RdZ70naLGtWhRs36J--O1nxqoqf18JjoF3GRc=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 July 2014 12:08, Olof Johansson <olof@lixom.net> wrote:
> On Mon, Jul 28, 2014 at 09:57:54PM +0800, Haojian Zhuang wrote:
>> From: Kefeng Wang <kefeng.wang@linaro.org>
>>
>> The commit 93dc688 (ARM: 7684/1: errata: Workaround for Cortex-A15
>> erratum 798181 (TLBI/DSB operations)) introduced a workaround for
>> Cortex-A15 erratum 798181. Enable it for HIP04(Cortex-a15 r3p2).
>>
>> Signed-off-by: Kefeng Wang <kefeng.wang@linaro.org>
>> Singed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>
> There's no need to do this as a separate patch if you just added this entry in
> a different patch in the same series -- just fold this in with that.
>
>
> -Olof

OK

Regards
Haojian

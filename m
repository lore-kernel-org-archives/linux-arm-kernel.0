From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 9 Apr 2015 09:23:50 +0200
Subject: [PATCH 3/8] clk: Constify pointers to parent names in init data
In-Reply-To: <5525BB7F.7070609@codeaurora.org>
References: <1428499339-29569-1-git-send-email-k.kozlowski@samsung.com>
 <1428499339-29569-4-git-send-email-k.kozlowski@samsung.com>
 <5525BB7F.7070609@codeaurora.org>
Message-ID: <CAJKOXPemyM8fa1gy5n=Kpeva2VBK+KguLF6_nrUtXeq3zjFAnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-09 1:36 GMT+02:00 Stephen Boyd <sboyd@codeaurora.org>:
> On 04/08/15 06:22, Krzysztof Kozlowski wrote:
>> The 'parent_names' member of 'clk_init_data' is not modified so it can
>> be made as an array of const pointers to constant strings.
>>
>> Some drivers (e.g. arch/mips/alchemy/common/clock.c) already pass such
>> data.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>
> Sascha sent a similar patch a few days ago.
>
> http://lkml.kernel.org/r/1427825817-26773-2-git-send-email-s.hauer at pengutronix.de

Indeed, so this patch can be skipped. I see that whole Sasha's
patchset is at v11 so maybe you could pick up only that patch? That
would allow applying other patches from here.

Best regards,
Krzysztof

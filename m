From: k.kozlowski.k@gmail.com (=?UTF-8?Q?Krzysztof_Koz=C5=82owski?=)
Date: Wed, 20 May 2015 14:03:40 +0900
Subject: [RESEND PATCH 2/2] ARM: dts: tegra: Use labels for overriding
 nodes in Tegra114 boards
In-Reply-To: <CAAVeFu+-EYwZ9veNK8T6ZTc9tV0ZgGGm4M6vsiXe70TGTvfOzA@mail.gmail.com>
References: <1432036279-6318-1-git-send-email-k.kozlowski.k@gmail.com>
 <1432036279-6318-2-git-send-email-k.kozlowski.k@gmail.com>
 <CAAVeFu+-EYwZ9veNK8T6ZTc9tV0ZgGGm4M6vsiXe70TGTvfOzA@mail.gmail.com>
Message-ID: <CAJKOXPeDSOwRU4Btt97Tf6Qd1zj5ctVnL_3-_RWGSy004SAACA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-20 13:05 GMT+09:00 Alexandre Courbot <gnurou@gmail.com>:
> On Tue, May 19, 2015 at 8:51 PM, Krzysztof Kozlowski
> <k.kozlowski.k@gmail.com> wrote:
>> Usage of labels instead of full paths reduces possible mistakes when
>> overriding nodes.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
>
> Indentation seems to be off by one tab in the added code (hence the
> huge size of this patch ; most lines should not change), can you
> check?

It is correct. This change in indentation is an effect of moving nodes
out of first bracket ("\ {"). That is the convention.

It us up to you guys if this is worth the effort. For exynos we use
label-convention and now I am converting old DTS to it. I think the
label-convention is less error-prone when extending or overriding
nodes. Also it removes duplicated addresses.

Best regards,
Krzysztof

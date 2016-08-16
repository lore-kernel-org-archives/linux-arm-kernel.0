From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 16 Aug 2016 10:41:45 +0200
Subject: [PATCH 2/8] ARM: dts: sun8i: Add dt node for rtl8703as wifi chip
 on ga10h
In-Reply-To: <CAGb2v67=54_cW6Svt2ZNvtMXwOU7wvzj_V6MT0fGB9hAjX=8PA@mail.gmail.com>
References: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
 <1470685398-14568-2-git-send-email-hdegoede@redhat.com>
 <CAGb2v67=54_cW6Svt2ZNvtMXwOU7wvzj_V6MT0fGB9hAjX=8PA@mail.gmail.com>
Message-ID: <e8dbda57-a931-0f13-28b3-9cb63bb0f5c4@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16-08-16 04:43, Chen-Yu Tsai wrote:
> On Tue, Aug 9, 2016 at 3:43 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> The ga10h tablet has a rtl8703as wifi chip, add a dt node describing it.
>>
>> This enables usage of wifi on this tablet (together with the out of
>> tree rtl8732bs driver).
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
>
> Does the chip or board support out of band interrupts?

I believe so, but since the sunxi-mmc controller properly supports
sdio-irq-s (without needing to poll) there is not to much to win there,
so currently I've no plans to support this (this would require defining
a dt binding + dts changes + driver changes).

Regards,

Hans

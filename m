From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 16 Aug 2016 10:43:29 +0800
Subject: [PATCH 2/8] ARM: dts: sun8i: Add dt node for rtl8703as wifi chip
 on ga10h
In-Reply-To: <1470685398-14568-2-git-send-email-hdegoede@redhat.com>
References: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
 <1470685398-14568-2-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v67=54_cW6Svt2ZNvtMXwOU7wvzj_V6MT0fGB9hAjX=8PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 9, 2016 at 3:43 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> The ga10h tablet has a rtl8703as wifi chip, add a dt node describing it.
>
> This enables usage of wifi on this tablet (together with the out of
> tree rtl8732bs driver).
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

Does the chip or board support out of band interrupts?

From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 6 Jun 2016 15:15:03 +0800
Subject: [PATCH 2/2] ARM: dts: sun7i: HDMI and the tv-encoder use tcon ch1
 not ch0
In-Reply-To: <1465129368-22335-2-git-send-email-hdegoede@redhat.com>
References: <1465129368-22335-1-git-send-email-hdegoede@redhat.com>
 <1465129368-22335-2-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v66bq2O7PjjytgL_kicARocctrWDYrhumUL0Ya0HHJQrHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 5, 2016 at 8:22 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Update the simplefb nodes for hdmi / tv-encoder out to point to
> tcon0_ch1 instead of tcon0_ch0 as tcon clock.
>
> While at it fix the clocks lines being longer then 80 chars.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

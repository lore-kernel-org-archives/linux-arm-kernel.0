From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 16 Oct 2015 11:29:25 +0800
Subject: [PATCH 1/2] pinctrl: sunxi: Fix irq_of_xlate for the r_pio
 pinctrl block
In-Reply-To: <1444919246-23694-2-git-send-email-hdegoede@redhat.com>
References: <1444919246-23694-1-git-send-email-hdegoede@redhat.com>
 <1444919246-23694-2-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v64ycY62O6FS14J_5zae=ZUL-b0+cfDNgaK6J=Pfq6TFHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 10:27 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> The r_pio gpio / pin controller has a pin_base of non 0, we need to
> adjust for this before calling sunxi_pinctrl_desc_find_function_by_pin.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

Thanks!

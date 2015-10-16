From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 16 Oct 2015 15:57:23 +0800
Subject: [PATCH v2 1/2] pinctrl: sunxi: Fix irq_of_xlate for the r_pio
 pinctrl block
In-Reply-To: <1444981572-17235-2-git-send-email-hdegoede@redhat.com>
References: <1444981572-17235-1-git-send-email-hdegoede@redhat.com>
 <1444981572-17235-2-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v64veFtkz3ds7csHEtde5tw=wMFqN04iGvLmANE9iGWByg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 3:46 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> The r_pio gpio / pin controller has a pin_base of non 0, we need to
> adjust for this before calling sunxi_pinctrl_desc_find_function_by_pin.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

Thanks!

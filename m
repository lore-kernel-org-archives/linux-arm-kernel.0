From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 16 Oct 2015 15:57:54 +0800
Subject: [PATCH v2 2/2] pinctrl: sunxi: Add irq pinmuxing to sun6i "r"
 pincontroller
In-Reply-To: <1444981572-17235-3-git-send-email-hdegoede@redhat.com>
References: <1444981572-17235-1-git-send-email-hdegoede@redhat.com>
 <1444981572-17235-3-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v64Au9HkouYt6TNWzMtDBm62WSRPsAeaS+C_vkrsPf5r4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 3:46 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Add pinmuxing for external interrupt functionality through the
> sun6i "r" pincontroller.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

Thanks!

> ---
> Changes in v2:
> -Fix compile error introduced by last minute changes before sending out
>  the patch (note to self: always do a recompile in such a case)

Sorry I didn't catch that either.

From: dianders@chromium.org (Doug Anderson)
Date: Thu, 19 Nov 2015 16:38:59 -0800
Subject: [PATCH v3 2/8] phy: rockchip-usb: introduce a common data-struct
 for the device
In-Reply-To: <1447968149-10979-3-git-send-email-heiko@sntech.de>
References: <1447968149-10979-1-git-send-email-heiko@sntech.de>
 <1447968149-10979-3-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=VdbGfpnhgmUR65b4zD6XpB97qseDrxtRJerRfjd9DpFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Thu, Nov 19, 2015 at 1:22 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> This introduces a common struct that holds data belonging to
> the umbrella device that contains all the phys and that we
> want to use later.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/phy/phy-rockchip-usb.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)

Huh, apparently in my whole talk about bindings I forgot my review
last time.  :(

Reviewed-by: Douglas Anderson <dianders@chromium.org>

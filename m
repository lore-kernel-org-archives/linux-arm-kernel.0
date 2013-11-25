From: dianders@chromium.org (Doug Anderson)
Date: Mon, 25 Nov 2013 15:11:27 -0800
Subject: [PATCH] ARM: dts: Add max77686 RTC interrupt to cros5250-common
In-Reply-To: <1382533861-12688-1-git-send-email-dianders@chromium.org>
References: <1382533861-12688-1-git-send-email-dianders@chromium.org>
Message-ID: <CAD=FV=VHLHL-VxUr_G7CoBQ5UY8t1jbdTCwcGz9BYrR5C3cpAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof or Kukjin,

On Wed, Oct 23, 2013 at 6:11 AM, Doug Anderson <dianders@chromium.org> wrote:
> Without the interrupt you'll get problems if you enable
> CONFIG_RTC_DRV_MAX77686.  Setup the interrupt properly in the device
> tree.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  arch/arm/boot/dts/cros5250-common.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Would one of you be interested in applying this to your tree, with
Marc's "Tested-by"?  I know there are lots more things to fixup in the
dts, but this is one that I know works.  ;)

-Doug

From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 Nov 2015 14:53:04 +0100
Subject: [PATCH] pwm: sun4i: Add support for pwm controller on sun5i SoCs
In-Reply-To: <1444556997-28885-1-git-send-email-hdegoede@redhat.com>
References: <1444556997-28885-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20151106135304.GD31835@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 11, 2015 at 11:49:57AM +0200, Hans de Goede wrote:
> The pwm controller on sun5i SoCs is identical to the one found on sun7i
> SoCs. On the A13 package only one of the 2 pins is routed to the outside,
> so only advertise one pwm there.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sun4i.txt          |  2 ++
>  drivers/pwm/pwm-sun4i.c                            | 25 ++++++++++++++++++++--
>  2 files changed, 25 insertions(+), 2 deletions(-)

Applied, thanks (with s/pwm/PWM/).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/42f5bf7d/attachment.sig>

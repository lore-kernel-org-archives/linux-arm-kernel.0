From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 Dec 2014 19:20:11 +0100
Subject: [PATCH v2 02/13] pinctrl: sun6i: Add A31s pinctrl support
In-Reply-To: <1418836704-15689-3-git-send-email-hdegoede@redhat.com>
References: <1418836704-15689-1-git-send-email-hdegoede@redhat.com>
 <1418836704-15689-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20141219182011.GS4820@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 06:18:13PM +0100, Hans de Goede wrote:
> The A31s is a stripped down version of the A31, as such it is missing some
> pins and some functions on some pins.
> 
> The new pinctrl-sun6i-a31s.c this commit adds is a copy of pinctrl-sun6i-a31s.c

I guess you meant pinctrl-sun6i-a31.c for the second one, right?

> with the missing pins and functions removed.
> 
> Note there is no a31s specific version of pinctrl-sun6i-a31-r.c, as the
> prcm pins are identical between the A31 and the A31s.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

We should probably refactor it at some point like mvebu does though to
deal with similar pin sets like this and the A31.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141219/deec71bf/attachment-0001.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 27 May 2014 10:02:57 +0200
Subject: [PATCH 01/11] pinctrl: sunxi: create irq/pin mapping during init
In-Reply-To: <1401090486-4414-2-git-send-email-hdegoede@redhat.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
 <1401090486-4414-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20140527080257.GA4730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 26, 2014 at 09:47:56AM +0200, Hans de Goede wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The irq/pin mapping is used to lookup the pin to mux to the irq
> function when the irq is enabled. It is created when gpio_to_irq
> is called. Creating the mapping during init allows us to map the
> interrupts directly from the device tree.

Can you be a bit more precise on this?

What is the issue that this patch fix?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140527/b9e1c07b/attachment.sig>

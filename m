From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Jun 2016 22:38:38 +0200
Subject: [PATCH 1/4] ARM: dts: sun5i: Enable otg on the auxtex t004
In-Reply-To: <1467226022-10525-1-git-send-email-hdegoede@redhat.com>
References: <1467226022-10525-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160629203838.GI6095@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 29, 2016 at 08:46:59PM +0200, Hans de Goede wrote:
> The auxtek t004 has its otg usb vbus hardwired to 5v (likely in case
> people use it to power the board instead of the dedicated power micro
> usb connector), it does have an id pin, so it allows full otg
> functionality.

I don't really get what you're saying here. Is the VBUS hardcoded to
5V, without any way to switch it, or it is not wired at all?

In the former case, how can one of the PMIC output be related to the
board power input?

Thanks,
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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160629/7630b06c/attachment.sig>

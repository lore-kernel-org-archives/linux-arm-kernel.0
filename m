From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Apr 2015 12:09:42 +0200
Subject: [PATCH] ARM: sunxi: Enable simplefb in the defconfig
In-Reply-To: <1429559320-27519-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1429559320-27519-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150427100942.GR5627@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 20, 2015 at 09:48:40PM +0200, Maxime Ripard wrote:
> Now that we have simplefb support, we can enable it in our defconfig. Also
> enable the framebuffer console, so that we are sure that we actually get
> something displayed in any case.
> 
> And while we're at it, enable the module support.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150427/7e81f59d/attachment.sig>

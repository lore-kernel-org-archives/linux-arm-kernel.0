From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 1 Jan 2014 23:56:43 +0100
Subject: [PATCH] ARM: sunxi: Select RESET_CONTROLLER
In-Reply-To: <1388417849-7728-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1388417849-7728-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140101225643.GA3144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 30, 2013 at 04:37:29PM +0100, Maxime Ripard wrote:
> The current code selects ARCH_HAS_RESET_CONTROLLER, that enables the
> RESET_CONTROLLER option by default, but doesn't select it, so a configuration
> might unselect it, leading to compilation error.
> 
> Explictly select RESET_CONTROLLER so that we can't have this breakage anymore.
> 
> Reported-by: Emilio L?pez <emilio@elopez.com.ar>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Merged in sunxi/core-for-3.14.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140101/1da3dc11/attachment.sig>

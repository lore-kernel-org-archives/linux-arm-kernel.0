From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 28 Sep 2016 23:16:10 +0200
Subject: [PATCH][v2] drm/sun4i: rgb: Enable panel after controller
In-Reply-To: <20160926102146.19129-1-net147@gmail.com>
References: <20160926102146.19129-1-net147@gmail.com>
Message-ID: <20160928211610.GO4189@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 26, 2016 at 08:21:45PM +1000, Jonathan Liu wrote:
> The panel should be enabled after the controller so that we do not have
> visual glitches on the panel while the controller is setup. Similarly,
> the panel should be disabled before the controller.
> 
> Signed-off-by: Jonathan Liu <net147@gmail.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160928/2e997576/attachment-0001.sig>

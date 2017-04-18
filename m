From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Apr 2017 07:34:58 +0200
Subject: [PATCH] arm64: dts: allwinner: a64: Add UART2 pin nodes
In-Reply-To: <20170414171320.19743-1-afaerber@suse.de>
References: <20170414171320.19743-1-afaerber@suse.de>
Message-ID: <20170418053458.phcbp4da3vatejpg@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 07:13:20PM +0200, Andreas F?rber wrote:
> UART2 is exposed on the Pi connector of Pine64. Make a pinctrl node
> available at the SoC level, to simplify enabling UART2 via DT overlay.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

Applied, thanks!

Could you also create the node in the pine64 DTS (with an explicit
status = "disabled" in there) so that the overlay would be even easier
to make ?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170418/ffcc2c87/attachment.sig>

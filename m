From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jan 2016 16:52:10 +0100
Subject: [PATCH RFC 04/11] clk: sunxi: factors: Add unregister function
In-Reply-To: <1453727747-23307-5-git-send-email-wens@csie.org>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
 <1453727747-23307-5-git-send-email-wens@csie.org>
Message-ID: <20160127155210.GH4317@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 09:15:40PM +0800, Chen-Yu Tsai wrote:
> sunxi's factors clk did not have an unregister function. This means
> multiple structs were leaked whenever a factors clk was unregistered.
> 
> Add an unregister function for it. Also keep pointers to the mux and
> gate structs so they can be freed.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/8e5a0488/attachment-0001.sig>

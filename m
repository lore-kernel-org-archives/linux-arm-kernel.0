From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 Jan 2015 17:26:21 +0100
Subject: [PATCH v3 01/13] clk: sunxi: Add a common setup function for mmc
 module clocks
In-Reply-To: <1421113055-17867-2-git-send-email-wens@csie.org>
References: <1421113055-17867-1-git-send-email-wens@csie.org>
 <1421113055-17867-2-git-send-email-wens@csie.org>
Message-ID: <20150114162621.GV4891@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 09:37:23AM +0800, Chen-Yu Tsai wrote:
> The only difference between module clocks on different platforms is the
> width of the mux register bits and the valid values, which are passed in
> through struct factors_data. The phase clocks parts are identical.
> 
> This patch generalizes the setup function, so most of the code can be
> reused when adding sun9i support, which has a wider mux register.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150114/aaf2b557/attachment.sig>

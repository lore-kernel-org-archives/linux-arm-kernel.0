From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Feb 2016 13:07:38 +0100
Subject: [PATCH 1/5] clk: sunxi: Make clocks setup functions return their
 clock
In-Reply-To: <1454402834-6385-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1454402834-6385-1-git-send-email-maxime.ripard@free-electrons.com>
 <1454402834-6385-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160204120738.GD4270@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 09:47:10AM +0100, Maxime Ripard wrote:
> The clocks registration code in clk-sunxi was most of the time not
> returning the struct clk (or struct clk array) that was registered,
> preventing the users of such functions to manipulate it, for example to
> protect it.
> 
> Make them return it so that we can start using it.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

After discussing it with Chen-Yu on IRC, the error logging will be
done as a subsequent patch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160204/72a9f1ac/attachment.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Feb 2016 19:02:27 +0100
Subject: [PATCH 08/11] clk: sunxi: improve error reporting for the mux
 clock
In-Reply-To: <1454348370-3816-9-git-send-email-andre.przywara@arm.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-9-git-send-email-andre.przywara@arm.com>
Message-ID: <20160202180227.GC4652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 05:39:27PM +0000, Andre Przywara wrote:
> clk_register_mux returns a pointer wrapped error value in case of
> failure, so a simple NULL check is not sufficient to catch errors.
> Fix that and elaborate on the failure reason on the way. The whole
> function does not return any error value, so silently failing may
> leave users scratching their heads because the kernel does not
> provide any clues on what's wrong.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Applied, thanks.

Any chance you do that for the other functions? :)

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160202/d0225674/attachment-0001.sig>

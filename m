From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 26 Apr 2015 18:11:57 +0200
Subject: [PATCH] ARM: sunxi: dts: Add A10 uarts pin muxing options
In-Reply-To: <1430043338-28982-1-git-send-email-richard.genoud@gmail.com>
References: <1430043338-28982-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <20150426161157.GM5627@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Sun, Apr 26, 2015 at 12:15:38PM +0200, Richard Genoud wrote:
> The A10 has 8 uarts, only uart0 and uart1 where filled.
> This patch adds all the missing uarts(2 to 7) pin muxing to the dtsi.
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

It's obviously correct, but I'd rather not add new pinctrl nodes that
don't have any users so that it doesn't bloat the DT without any
particular reason.

Feel free to resubmit this patch if one of these nodes become actually
useful.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150426/fa36aaa2/attachment-0001.sig>

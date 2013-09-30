From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Sep 2013 19:03:17 +0200
Subject: [PATCH 01/10] clk: sunxi: register factors clocks behind composite
In-Reply-To: <1380426579-32458-2-git-send-email-emilio@elopez.com.ar>
References: <1380426579-32458-1-git-send-email-emilio@elopez.com.ar>
 <1380426579-32458-2-git-send-email-emilio@elopez.com.ar>
Message-ID: <20130930170317.GC5287@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 29, 2013 at 12:49:30AM -0300, Emilio L?pez wrote:
> This commit reworks factors clock registration to be done behind a
> composite clock. This allows us to additionally add a gate, mux or
> divisors, as it will be needed by some future PLLs.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130930/fb77a3f2/attachment-0001.sig>

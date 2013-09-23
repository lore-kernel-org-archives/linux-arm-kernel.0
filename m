From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Sep 2013 19:57:27 +0300
Subject: [PATCH 2/3] clk: sunxi: factors: clear variables before using them
In-Reply-To: <1379725392-30202-3-git-send-email-emilio@elopez.com.ar>
References: <1379725392-30202-1-git-send-email-emilio@elopez.com.ar>
 <1379725392-30202-3-git-send-email-emilio@elopez.com.ar>
Message-ID: <20130923165727.GN2779@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 20, 2013 at 10:03:11PM -0300, Emilio L?pez wrote:
> Random bits may get into our factors if we don't clear n, k, m and p.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130923/b34eb042/attachment.sig>

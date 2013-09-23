From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Sep 2013 19:56:42 +0300
Subject: [PATCH 1/3] clk: sunxi: factors: fix off-by-one masks
In-Reply-To: <1379725392-30202-2-git-send-email-emilio@elopez.com.ar>
References: <1379725392-30202-1-git-send-email-emilio@elopez.com.ar>
 <1379725392-30202-2-git-send-email-emilio@elopez.com.ar>
Message-ID: <20130923165642.GM2779@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 20, 2013 at 10:03:10PM -0300, Emilio L?pez wrote:
> The previous code would generate one bit too long masks, and was
> needlessly complicated. This patch replaces it by simpler code that can
> generate the masks correctly.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130923/73614c4b/attachment.sig>

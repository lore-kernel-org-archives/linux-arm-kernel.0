From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Sep 2013 20:00:33 +0300
Subject: [PATCH 3/3] clk: sunxi: protect core clocks from accidental
 shutdown
In-Reply-To: <1379725392-30202-4-git-send-email-emilio@elopez.com.ar>
References: <1379725392-30202-1-git-send-email-emilio@elopez.com.ar>
 <1379725392-30202-4-git-send-email-emilio@elopez.com.ar>
Message-ID: <20130923170033.GO2779@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 20, 2013 at 10:03:12PM -0300, Emilio L?pez wrote:
> Some important clocks may get disabled as a side effect of another clock
> being disabled, because they have no consumers. This patch implements a
> mechanism so those clocks can be claimed by the driver and therefore
> remain enabled at all times.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130923/878c7f57/attachment.sig>

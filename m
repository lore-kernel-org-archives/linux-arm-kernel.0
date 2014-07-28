From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Jul 2014 15:21:47 +0200
Subject: [RFC 5/8] clk: sunxi: staticize structures and arrays
In-Reply-To: <1406519386-4902-6-git-send-email-emilio@elopez.com.ar>
References: <1406519386-4902-1-git-send-email-emilio@elopez.com.ar>
 <1406519386-4902-6-git-send-email-emilio@elopez.com.ar>
Message-ID: <20140728132147.GK3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 12:49:43AM -0300, Emilio L?pez wrote:
> There are some structs and arrays on the driver that are not used
> anywhere else. Let's mark them as static.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140728/cdedde34/attachment-0001.sig>

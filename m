From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Nov 2014 21:29:27 +0100
Subject: [PATCH v2 1/5] phy: sun4i: add support for USB phy0
In-Reply-To: <997f1e2744504f3461f9e94e2171180b5ce87aa2.1415645258.git.rbyshko@gmail.com>
References: <cover.1415645258.git.rbyshko@gmail.com>
 <997f1e2744504f3461f9e94e2171180b5ce87aa2.1415645258.git.rbyshko@gmail.com>
Message-ID: <20141112202927.GB20972@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 07:55:06PM +0100, Roman Byshko wrote:
> The driver for sun4i USB phys currently supports
> only phy1 and phy2 which are used for USB host
> controllers. This patch adds support for USB phy0,
> which is used by the musb hdrc USB controller.
> 
> Signed-off-by: Roman Byshko <rbyshko@gmail.com>

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
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141112/00769842/attachment.sig>

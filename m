From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 3 Aug 2014 14:41:08 +0200
Subject: [PATCH 3/9] ARM: sunxi: make sun6i SMP ops static
In-Reply-To: <1406842092-25207-4-git-send-email-emilio@elopez.com.ar>
References: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
 <1406842092-25207-4-git-send-email-emilio@elopez.com.ar>
Message-ID: <20140803124108.GT3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 06:28:06PM -0300, Emilio L?pez wrote:
> The sun6i SMP ops are currently not marked as static, as reported by
> sparse. Let's mark it as such.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

That patch has nothing to do in this set. Please send it separately.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140803/9fd0e1c1/attachment.sig>

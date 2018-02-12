From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 12 Feb 2018 21:59:39 +0100
Subject: [PATCH v5 13/26] watchdog: renesas_wdt: Add restart handler
In-Reply-To: <1518457475-4480-14-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1518457475-4480-14-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20180212205939.75pszm5ih6ndw32h@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 05:44:22PM +0000, Fabrizio Castro wrote:
> On iWave's boards iwg20d and iwg22d the only way to reboot the system is
> by means of the watchdog.
> This patch adds a restart handler to rwdt_ops, and also makes sure we
> keep its priority to a medium level, in order to not override other more
> effective handlers.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180212/9ad7f346/attachment.sig>

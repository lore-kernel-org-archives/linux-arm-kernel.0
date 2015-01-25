From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 Jan 2015 19:23:12 +0100
Subject: [PATCH 3/6] power/reset: Remove sun6i reboot driver
In-Reply-To: <1422209622-31994-3-git-send-email-linux@roeck-us.net>
References: <1422209622-31994-1-git-send-email-linux@roeck-us.net>
 <1422209622-31994-3-git-send-email-linux@roeck-us.net>
Message-ID: <20150125182312.GO8470@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 25, 2015 at 10:13:39AM -0800, Guenter Roeck wrote:
> sun6i restart is now handled by its watchdog driver directly,
> so this driver is no longer needed.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150125/128b8f3e/attachment.sig>

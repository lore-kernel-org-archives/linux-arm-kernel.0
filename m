From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 12:34:01 -0700
Subject: [PATCH v9 01/17] clk: sunxi: factors: automatic reparenting
 support
In-Reply-To: <1398507381-5614-2-git-send-email-hdegoede@redhat.com>
References: <1398507381-5614-1-git-send-email-hdegoede@redhat.com>
 <1398507381-5614-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20140428193401.GH3134@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 26, 2014 at 12:16:05PM +0200, Hans de Goede wrote:
> From: Emilio L?pez <emilio@elopez.com.ar>
> 
> This commit implements .determine_rate, so that our factor clocks can be
> reparented when needed.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/75db8e6a/attachment-0001.sig>

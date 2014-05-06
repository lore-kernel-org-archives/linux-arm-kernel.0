From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 May 2014 13:51:31 -0500
Subject: [PATCH v10 01/15] clk: sunxi: factors: automatic reparenting
 support
In-Reply-To: <1399046249-19472-2-git-send-email-hdegoede@redhat.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
 <1399046249-19472-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20140506185131.GI9464@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Fri, May 02, 2014 at 05:57:15PM +0200, Hans de Goede wrote:
> From: Emilio L?pez <emilio@elopez.com.ar>
> 
> This commit implements .determine_rate, so that our factor clocks can be
> reparented when needed.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Any chance you merge this? Since it's pretty consensual, needed by
other drivers, and that you are the author, I can it can go in.

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
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140506/6bd053c0/attachment.sig>

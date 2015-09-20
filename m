From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 20 Sep 2015 18:49:37 +0200
Subject: [PATCH] pinctrl: sun5i: Fix a10s pwm1 pinctrl mapping
In-Reply-To: <1442699804-15526-1-git-send-email-hdegoede@redhat.com>
References: <1442699804-15526-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150920164937.GH4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 19, 2015 at 05:56:44PM -0400, Hans de Goede wrote:
> The comment for PG14 mux setting 3 already correctly states that this
> muxes PG13 to pwm1, but the text ascociated with it said uart3, fix this.
> 
> Note that we use "pwm" rather then "pwm1" to be consistent with pwm0
> where the mux setting is also simply called "pwm" and to be consistent
> with sun4i/sun7i which do the same.
> 
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
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150920/68a7caf5/attachment.sig>

From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 7 Mar 2018 08:40:58 +0100
Subject: [PATCH 1/5] pwm: sun4i: drop unused .has_rdy member
In-Reply-To: <20180307020719.6675-2-andre.przywara@arm.com>
References: <20180307020719.6675-1-andre.przywara@arm.com>
 <20180307020719.6675-2-andre.przywara@arm.com>
Message-ID: <20180307074058.yvnayz7zywk24jt3@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2018 at 02:07:15AM +0000, Andre Przywara wrote:
> Commit a054c4d68408 ("pwm: sun4i: Drop legacy callbacks") dropped the
> only user of the .has_rdy member in our sun4i_pwm_data struct.
> Consequently we don't need to store this anymore for the various SoCs,
> which paves the way for further simplifications.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180307/a9bf98a7/attachment-0001.sig>

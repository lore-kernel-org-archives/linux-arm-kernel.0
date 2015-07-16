From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Jul 2015 16:05:00 +0100
Subject: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
In-Reply-To: <1437056116.28351.19.camel@tiscali.nl>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
 <1437033944.27428.11.camel@tiscali.nl>
 <20150716110032.GU11162@sirena.org.uk>
 <1437047261.28351.6.camel@tiscali.nl>
 <20150716125529.GG4039@sirena.org.uk>
 <1437056116.28351.19.camel@tiscali.nl>
Message-ID: <20150716150500.GO4039@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 04:15:16PM +0200, Paul Bolle wrote:

> Let's put it this was. If one does
>     sudo find /sys -perm -o=r -name uevent -exec grep -H MODALIAS=platform: {} \;
> 
> or
>     sudo find /sys -perm -o=r -name modalias -exec grep -H platform: {} \;

> (both lists should be similar)

> on the systems this patch is targeting, will
>    platform:rockchip-snd-max98090

> then show up?

Why would this not be the case - what is the difference you beleive this
driver has to other platform drivers?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150716/17f839cb/attachment.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 27 Dec 2015 21:51:51 +0100
Subject: [PATCH] ARM: dts: sun4i: Use red1 LED for heartbeat indication
 on Marsboard A10
In-Reply-To: <1451123879-7212-1-git-send-email-mamlinav@gmail.com>
References: <1451123879-7212-1-git-send-email-mamlinav@gmail.com>
Message-ID: <20151227205151.GK30359@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 26, 2015 at 12:57:59PM +0300, Aleksei Mamlin wrote:
> Marsboard A10 have four red LEDs, the first one can be used for
> heartbeat indication.
> 
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>

I'm really not sure about this one.

This is something that can easily be changed through sysfs, and it
will likely end up being a "war" on what trigger people want to use.

Hans, Chen-Yu, What's your view on this?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151227/aa02729c/attachment.sig>

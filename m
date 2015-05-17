From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 17 May 2015 16:31:32 +0200
Subject: [PATCH v2 08/10] reset: sunxi: Add compatible for Allwinner H3
 bus resets
In-Reply-To: <1431707940-19372-9-git-send-email-jenskuske@gmail.com>
References: <1431707940-19372-1-git-send-email-jenskuske@gmail.com>
 <1431707940-19372-9-git-send-email-jenskuske@gmail.com>
Message-ID: <20150517143132.GI4004@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 06:38:58PM +0200, Jens Kuske wrote:
> Adding a new compatible allows us to define SoC specific behaviour
> if necessary, for example forcing a particular device out of reset
> even if no driver is actually using it.
> 
> Signed-off-by: Jens Kuske <jenskuske@gmail.com>

This should have been sent to the reset framework maintainer.

Looks good otherwise.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150517/bcc6a963/attachment-0001.sig>

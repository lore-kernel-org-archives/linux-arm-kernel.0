From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Jan 2018 13:47:01 +0100
Subject: [PATCH v1 3/4] ARM: dts: add pwm pins for r40.
In-Reply-To: <20180111113323.GA21976@arx-s1>
References: <20180111113323.GA21976@arx-s1>
Message-ID: <20180111124701.g52kjm3hozn72je5@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 11, 2018 at 07:33:23PM +0800, hao_zhang wrote:
> This patch add pwm pins for r40.
> 
> Signed-off-by: hao_zhang <hao5781286@gmail.com>

You should order your patches differently. We try to be as bisectable
as possible, and if we just apply this patch the DT will not compile
anymore.

Your patch 4 should come before this one.

Your commit title and log doesn't seem to match the content of the
patch either.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180111/48365930/attachment.sig>

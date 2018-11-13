From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Nov 2018 14:10:11 +0100
Subject: [PATCH v2 2/2] arm64: dts: allwinner: a64: Add device node for
 Mali-400 GPU
In-Reply-To: <20181113120054.17639-2-jagan@amarulasolutions.com>
References: <20181113120054.17639-1-jagan@amarulasolutions.com>
 <20181113120054.17639-2-jagan@amarulasolutions.com>
Message-ID: <20181113131011.t7r5m3vks4cyec4v@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 05:30:54PM +0530, Jagan Teki wrote:
> Add support for Allwinner A64 has Mali-400MP2.
> 
> All interrupt lines are mentioned in the manual so used the same.
> Used 408MHz as assigned clock rate used by BSP, so used the same as
> well.

You're not using that frequency anywhere.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181113/de06ebaa/attachment.sig>

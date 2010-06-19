From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 19 Jun 2010 02:36:29 +0100
Subject: [PATCH] ASoC: Fix overflow bug in SOC_DOUBLE_R_SX_TLV
In-Reply-To: <1276829770-31557-1-git-send-email-redhatter@gentoo.org>
References: <20100618023810.GS7759@www.longlandclan.yi.org>
	<1276829770-31557-1-git-send-email-redhatter@gentoo.org>
Message-ID: <20100619013629.GA2974@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 18, 2010 at 12:56:10PM +1000, Stuart Longland wrote:
> When SX_TLV widgets are read, if the gain is set to a value below 0dB,
> the mixer control is erroniously read as being at maximum volume.

Applied, thanks.

BTW, you might want to have a look at the CCs - you probably don't need
to CCing the ARM list for ASoC patches that aren't ARM specific, for
example.

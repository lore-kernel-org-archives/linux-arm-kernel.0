From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 Jun 2010 00:29:01 +0100
Subject: [PATCH 1/3] EP93xx: Add i2s core support
In-Reply-To: <4C0ED1B9.7020106@bluewatersys.com>
	(sfid-20100609_002659_105352_75064CA0)
References: <1275991272-30122-1-git-send-email-ryan@bluewatersys.com>
	<1275991272-30122-2-git-send-email-ryan@bluewatersys.com>
	<0D753D10438DA54287A00B027084269763708AFD76@AUSP01VMBX24.collaborationhost.net>
	<4C0E9987.2010907@bluewatersys.com>
	(sfid-20100608_202716_363612_846D1CC6)
	<94CDC52C-12BD-447E-B0ED-5E3950FF89BA@opensource.wolfsonmicro.com>
	<4C0ED1B9.7020106@bluewatersys.com>
	(sfid-20100609_002659_105352_75064CA0)
Message-ID: <079055B9-F238-400E-A94D-4B950A5C8C7B@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 Jun 2010, at 00:26, Ryan Mallon wrote:

> Patch 3 at least has a dependency on patch 1 for some #defines and the
> ep93xx_i2s functions calls.

Oh, in that case best if I take them both through ASoC unless someone anticipates issues there. I'll arrange things so they can also be merged into the ARM tree in case of issues.

From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 15 Sep 2011 09:43:47 +0100
Subject: [PATCHv2 0/3] Initial support for Picochip picoxcell
In-Reply-To: <1314196906-20709-1-git-send-email-jamie@jamieiles.com>
References: <1314196906-20709-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20110915084347.GA3089@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 03:41:43PM +0100, Jamie Iles wrote:
> This series adds support for Picochip picoXcell (PC3X2 and PC3X3)
> ARM1176JZ-S based devices.  This is a device tree only platform and
> currently supports interrupt controllers and UARTs.
> 
> This series is based off of Grant's devicetree/test branch and also uses
> Russell's io and gpio cleanup patches to remove the definition of
> IO_SPACE_LIMIT and trivial gpio definitions.
> 
> Changes since v1:
> 
> 	- Cleanup empty headers
> 	- Use of_platform_populate() and the default match table
> 	- Split the VIC's into separate device nodes

ping?

Jamie

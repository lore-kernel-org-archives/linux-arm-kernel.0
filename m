From: horms@verge.net.au (Simon Horman)
Date: Thu, 9 Jun 2016 09:55:23 +0900
Subject: [PATCH v2 4/4] ARM: dts: r8a7790: lager: use demuxer for IIC3/I2C3
In-Reply-To: <20160608080516.GI1521@katana>
References: <1465370066-8450-1-git-send-email-horms+renesas@verge.net.au>
 <1465370066-8450-5-git-send-email-horms+renesas@verge.net.au>
 <20160608080516.GI1521@katana>
Message-ID: <20160609005522.GC21650@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 10:05:16AM +0200, Wolfram Sang wrote:
> On Wed, Jun 08, 2016 at 04:14:26PM +0900, Simon Horman wrote:
> > Create a separate bus for dla98063 PMIC and da9210 regulator
> > related I2C slaves.
> > 
> > Based on similar work for HDMI by Wolfram Sang.
> > 
> > Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Maybe add a word that PFC doesn't allow I2C0/I2C3 to be muxed as GPIO?

Sure, will do.

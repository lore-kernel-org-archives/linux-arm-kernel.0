From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Wed, 3 Feb 2016 23:26:23 +0000
Subject: [PATCH v4 1/2] ARM: dts: imx6: Add support for Toradex Apalis
 iMX6Q/D SoM
In-Reply-To: <20160201132916.GF10671@tiger>
References: <1453675703-31594-1-git-send-email-marcel.ziswiler@toradex.com>
 <1453675703-31594-2-git-send-email-marcel.ziswiler@toradex.com>
 <20160201132916.GF10671@tiger>
Message-ID: <1454541981.11389.17.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-02-01 at 21:29 +0800, Shawn Guo wrote:

[snip]

> > +		stmpe_touchscreen {
> 
> Shouldn't the node name be generic as just touchscreen???Or at least,
> hyphen instead of underscore should be used in node name.

This one is actually as per binding document example:

Documentation/devicetree/bindings/input/touchscreen/stmpe.txt:

Example:

????????stmpe_touchscreen {

[snip]

From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 24 Jul 2014 08:11:37 -0400
Subject: [PATCH 2/2] ARM: mvebu: Added dts defintion for Lenovo Iomega
 ix4-300d NAS
In-Reply-To: <20140723234256.GN23220@titan.lakedaemon.net>
References: <1406155973-13657-1-git-send-email-yahoo@perenite.com>
 <20140723232715.GL23220@titan.lakedaemon.net>
 <20140723232909.GE28485@lunn.ch>
 <20140723234256.GN23220@titan.lakedaemon.net>
Message-ID: <20140724121137.GU23220@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit,

> On Thu, Jul 24, 2014 at 01:29:09AM +0200, Andrew Lunn wrote:
> > 
> > We should not really leave the i2c compatibility string as it is.
> > 

If you were to apply

  ed2d859119f9 ARM: mvebu: Fix broken SoC ID detection

And then remove the -a0 i2c compatible string, does your board boot?

The referenced patch has been in mainline since v3.16-rc3, so you could
just try that kernel w/o the compatible string.

thx,

Jason.

From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Thu, 13 Apr 2017 23:46:15 +0300
Subject: [RFC 4/8] regulator: core: Check enabling bypass respects
 constraints
In-Reply-To: <20170407112212.gzv3p7ldkh62657m@sirena.org.uk>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <1edff9bc610969b0c53fa1080d5db021c8e00b2d.1490199005.git.leonard.crestez@nxp.com>
 <20170324125212.vikgekqxsnu7htzl@sirena.org.uk>
 <1490704781.3546.57.camel@nxp.com>
 <20170328164754.z2c2ttovs3sxbcos@sirena.org.uk>
 <1490730595.15830.1.camel@nxp.com>
 <20170406185202.uixxcv3dgucrddgc@sirena.org.uk>
 <1491562312.9365.41.camel@nxp.com>
 <20170407112212.gzv3p7ldkh62657m@sirena.org.uk>
Message-ID: <1492116375.17723.15.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-04-07 at 12:22 +0100, Mark Brown wrote:
> On Fri, Apr 07, 2017 at 01:51:52PM +0300, Leonard Crestez wrote:

> > It currently seems to work how I expect but from your statement it's
> > not clear if it's entirely intentional.

> The current behaviour of bypassed regulators is intentional.

I did not mean to imply that there is something wrong with bypassed
regulators. I just wanted more information about how regulators (non-
bypassed) pick their voltage when consumers allow a range.

After some more reading through the code it seems that the driver
itself receives the range (either through set_voltage or map_voltage)
and gets to make the choice.

So it seems fine for my concerns, sorry to bother you.

--
Regards,
Leonard

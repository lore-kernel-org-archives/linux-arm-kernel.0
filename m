From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Feb 2012 13:27:50 +0000
Subject: [RFC 2/7] MFD: twl6040: Convert to i2c driver, and separate it
 from twl core
In-Reply-To: <4F2A8912.4070701@ti.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
 <1328185019-29575-3-git-send-email-peter.ujfalusi@ti.com>
 <20120202124828.GI7428@opensource.wolfsonmicro.com>
 <4F2A8912.4070701@ti.com>
Message-ID: <20120202132750.GM7428@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 03:01:06PM +0200, Peter Ujfalusi wrote:
> On 02/02/2012 02:48 PM, Mark Brown wrote:

> > The calling convention here seems a bit weird too, you've got value then
> > register but normally we have register then value for I2C/SPI devices.

> I have based these part on the twl-core's implementation. I should not
> have done that, I know.. Let's see how it will look like with regmap.

Yeah, like I say...

> > Except when we don't :(

...it's not like we've been consistent so far.  I'm not that fussed
either way, I probably wouldn't have mentioned it if I hadn't otherwise
been commenting.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120202/f81919fa/attachment.sig>

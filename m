From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 9 Feb 2015 13:50:37 +0200
Subject: [PATCHv6 0/2] Driver for TI tlc591xx 8/16 Channel i2c LED driver
In-Reply-To: <20150206031048.GA9614@lunn.ch>
References: <1422367161-16487-1-git-send-email-andrew@lunn.ch>
 <20150206031048.GA9614@lunn.ch>
Message-ID: <54D89F0D.9050506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/15 05:10, Andrew Lunn wrote:
> On Tue, Jan 27, 2015 at 02:59:19PM +0100, Andrew Lunn wrote:
>> This patchset is a driver for the TI tlc59116 16 Channel i2c LED
>> driver and tlc59108 8 Channel i2c LED driver. This driver is used on
>> the Belkin WRT1900AC access point and the C code is derived from code
>> Belkin contributed to OpenWRT.  However it has been extensively
>> re-written, and a device tree binding added to replace platform data.
> 
> Hi Bryan
> 
> Do you have any further comments on this driver? Are you likely to
> queue it up for the next merge window?

Hi Andrew,

You didn't comment anything on my and Peter's questions on v5 thread
about this being a PWM driver.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150209/d8e8263b/attachment.sig>

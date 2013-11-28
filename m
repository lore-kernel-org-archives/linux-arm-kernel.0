From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 28 Nov 2013 01:46:36 +0100
Subject: [PATCH 03/04] ARM: shmobile: Genmai I2C-over-GPIO support
In-Reply-To: <CANqRtoQkZHCCZ0hZrFkgndxoOrfdjnRZQR6NUP0KLMiRMxw2Gw@mail.gmail.com>
References: <20131127082736.20015.21303.sendpatchset@w520>
 <2757102.StIMV2khe5@avalon>
 <CANqRtoQkZHCCZ0hZrFkgndxoOrfdjnRZQR6NUP0KLMiRMxw2Gw@mail.gmail.com>
Message-ID: <3492627.E4uF2vqd6n@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Thursday 28 November 2013 09:44:31 Magnus Damm wrote:
> On Wed, Nov 27, 2013 at 8:15 PM, Laurent Pinchart wrote:
> > On Wednesday 27 November 2013 17:28:05 Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >> 
> >> Add support for the Genmai I2C bus hooked up to P1_5 and P1_4 using
> >> the i2c-gpio driver. On the bus sits a 24c128 EEPRROM.
> > 
> > Is this a temporary workaround until we get a proper I2C controller
> > driver, or is the EEPROM really hooked up to pins that are not wired to a
> > hardware I2C controller ?
> 
> This is a stop-gap solution until we have upstream driver support for the
> I2C master hardware.

OK, no problem. Is there a timeline for that ?

> The pins used for the I2C bus can be configured in GPIO mode or a zillion
> other pin functions including SCL and SDA.

-- 
Regards,

Laurent Pinchart

From: cmetcalf@tilera.com (Chris Metcalf)
Date: Mon, 1 Sep 2014 09:53:01 -0400
Subject: [PATCH 2/5] char: tile-srom: Remove reference to platform_bus
In-Reply-To: <1409574460.4343.7.camel@hornet>
References: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>	
 <1406298233-27876-2-git-send-email-pawel.moll@arm.com>	
 <53DAA605.2030500@tilera.com> <1406913678.22529.46.camel@hornet>	
 <53E139C8.9000502@tilera.com> <1407515691.31897.26.camel@hornet>	
 <5400C9C1.4060904@tilera.com> <1409574460.4343.7.camel@hornet>
Message-ID: <54047A3D.3090702@tilera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/1/2014 8:27 AM, Pawel Moll wrote:
> On Fri, 2014-08-29 at 19:43 +0100, Chris Metcalf wrote:
>> If the
>> consensus is that this is the way to go, I can certainly take this change
>> into the Tile tree.
> That would be cool, and left us only with the scsi/DMA as the last user
> of platform_bus. But this is a completely different story ;-)

OK, sounds good.  It's in the tile tree at linux-next now.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com

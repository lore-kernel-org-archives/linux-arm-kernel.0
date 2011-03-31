From: arend@broadcom.com (Arend van Spriel)
Date: Thu, 31 Mar 2011 12:41:16 -0000
Subject: [PATCH 0/1] new module for amba axi on-chip interconnect
Message-ID: <op.vs7j6jkw3ri7v4@arend-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 March 2011 20:08:57 +0100 Russell King - ARM Linux wrote:
> I think you're going to be waiting a very long time for that to happen.
> No SoC vendor adds device IDs to their on-chip devices to allow them to
> be automatically discovered - it's only through ARM Ltd's development of
> their Primecells, and then vendors integrating those into their SoC  
> (maybe
> with their own modifications) that we've started to see this kind of ID
> system appearing.

Actually, Broadcom does. ARM delivers the DMP plugin. This adds additional  
register space with each core and each core is identified with a vendor id  
(maintained by JEDEC to assure it is unique), a core id, and a core class.  
Another used interconnect is SSB which also offers discovery functionality.

> Outside of the Primecell stuff, I'm unaware of anyone adding any kind
> of discovery mechanism to SoC based devices.

Not sure either.

Gr. AvS
-- 
"The most merciful thing in the world, I think, is the inability of the  
human
mind to correlate all its contents." - "The Call of Cthulhu"

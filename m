From: jamie@shareable.org (Jamie Lokier)
Date: Sat, 5 Sep 2009 16:22:51 +0100
Subject: [PATCH] Add RGB555X and RGB565X formats to pxa-camera
In-Reply-To: <Pine.LNX.4.64.0909051037300.4670@axis700.grange>
References: <200908031031.00676.marek.vasut@gmail.com>
	<4A76CB7C.10401@gmail.com>
	<Pine.LNX.4.64.0908031415370.5310@axis700.grange>
	<200909050926.48309.marek.vasut@gmail.com>
	<Pine.LNX.4.64.0909051037300.4670@axis700.grange>
Message-ID: <20090905152251.GL24516@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guennadi Liakhovetski wrote:
 Now RGB555 looks like (from wikipedia)
> 
> 15  14  13  12  11  10  09  08  07  06  05  04  03  02  01  00
> R4  R3  R2  R1  R0  G4  G3  G2  G1  G1  B4  B3  B2  B1  B1  --
> 
> (Actually, I thought bit 15 was unused, but it doesn't matter for this 
> discussion.)

You are right: sometimes RGB555 means bit 15 is unused.  Wikipedia
isn't always right.

-- Jamie

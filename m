From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Dec 2015 10:04:38 +0000
Subject: [PATCH v2 1/3] dt-bindings: add Marvell PMU documentation
In-Reply-To: <181206520.JBMXuTWYTV@wuerfel>
References: <E1a5j6L-000873-3P@rmk-PC.arm.linux.org.uk>
 <181206520.JBMXuTWYTV@wuerfel>
Message-ID: <20151207100438.GL8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 10:09:48AM +0100, Arnd Bergmann wrote:
> On Sunday 06 December 2015 23:52:21 Russell King wrote:
> > Add the required DT binding documentation for the Marvell PMU driver.
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> > Who takes these patches?  This never got merged when the PMU driver
> > itself was merged.
> 
> I'd say it should go along with the dts changes for mvebu, and we'll
> merge it through arm-soc.

Well, it didn't, the dts changes are already in as well.  Someone now
needs to pick it up independently.

I wonder how many more of the undocumented bindings are actually caused
by people not realising that the binding docs patches have been ignored.
(Yes, I've found cases in the past where bindings are undocumented, and
no, I don't keep a list and I don't remember which they were.)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

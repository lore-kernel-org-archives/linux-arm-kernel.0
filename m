From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 07 Dec 2015 10:09:48 +0100
Subject: [PATCH v2 1/3] dt-bindings: add Marvell PMU documentation
In-Reply-To: <E1a5j6L-000873-3P@rmk-PC.arm.linux.org.uk>
References: <E1a5j6L-000873-3P@rmk-PC.arm.linux.org.uk>
Message-ID: <181206520.JBMXuTWYTV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 06 December 2015 23:52:21 Russell King wrote:
> Add the required DT binding documentation for the Marvell PMU driver.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> Who takes these patches?  This never got merged when the PMU driver
> itself was merged.

I'd say it should go along with the dts changes for mvebu, and we'll
merge it through arm-soc.

	Arnd

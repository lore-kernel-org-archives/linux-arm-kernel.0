From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 05 Nov 2012 18:03:20 +0000
Subject: Building for MMU-less vexpress targets
In-Reply-To: <20121105173640.GR3351@mudshark.cambridge.arm.com>
References: <20121105173640.GR3351@mudshark.cambridge.arm.com>
Message-ID: <1352138600.10947.26.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-11-05 at 17:36 +0000, Will Deacon wrote:
> I'm inclined to add a dummy VEXPRESS entry to arm/Kconfig which depends on
> !ARCH_MULTIPLATFORM and just selects ARCH_VEXPRESS (with the if ARCH_MULTI_V7
> dependency dropped) 

... depends on !ARCH_MULTIPLATFORM or maybe rather !MMU? (I assume you
want to add an extra dummy position in the choice section, where options
are mutually exclusive anyway?)

Pawe?

From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Apr 2013 22:46:12 +0200
Subject: [PATCH v2 0/9] rm: mvebu: Enable LPAE support for Armada XP SoCs
In-Reply-To: <1365193444-13441-1-git-send-email-gregory.clement@free-electrons.com>
References: <1365193444-13441-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201304052246.12731.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Gregory CLEMENT wrote:
> The Armada XP SoCs have LPAE support. This is the second version patch
> set whixh allow to run kernel on this SoCs with LPAE support.
> 
> The biggest changes are the conversion of the device tree file to 64
> bits in order to be able to use more than 4GB of memory (without this
> the LPAE is pointless).
> 

The series looks good overall, I've commented on trivial details.

Also, please use "ARM: mvebu: ..." in the subject rather than the lower-case
version.

	Arnd

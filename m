From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jun 2012 08:39:02 +0000
Subject: [PATCH v2 3/8] arm: mach-mvebu: add compilation/configuration
 change
In-Reply-To: <1339433585-28087-4-git-send-email-gregory.clement@free-electrons.com>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <1339433585-28087-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201206120839.02915.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 June 2012, Gregory CLEMENT wrote:
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Lior Amsalem <alior@marvell.com>

Please always keep this patch last in the series, as soon as it is applied,
one can build a kernel for mvebu, which ends up not working. Each step
in a patch series needs to provide a working, incremental improvement
over the previous one, so when adding a new feature in parts, you can
only enable it once you have something that actually builds.

	Arnd

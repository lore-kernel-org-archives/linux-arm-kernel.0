From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Nov 2011 17:43:38 +0000
Subject: [PATCH v2] atmel/spi: fix missing probe during the switch to
	module_platform_driver
In-Reply-To: <20111103165113.GL7136@game.jcrosoft.org>
References: <1320331706-4946-1-git-send-email-plagnioj@jcrosoft.com>
	<1320333042-24880-1-git-send-email-plagnioj@jcrosoft.com>
	<20111103151855.GP12913@n2100.arm.linux.org.uk>
	<20111103165113.GL7136@game.jcrosoft.org>
Message-ID: <20111103174338.GQ12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2011 at 05:51:13PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> this is an other fix I do not want to fix 2 issue in one commit and I do care
> of mismatch erros I fix them all the time I send patch for some rm9200 few
> weeks ago

It should not be a separate patch - it's all to do with fixing the
original problem.

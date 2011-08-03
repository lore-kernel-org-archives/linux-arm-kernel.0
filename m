From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Aug 2011 19:14:38 +0100
Subject: [PATCH] mach-davinci: fix cache flush build error
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024DF05E85@dbde02.ent.ti.com>
References: <1312300118-9088-1-git-send-email-linus.walleij@stericsson.com>
	<20110802160234.GH19079@n2100.arm.linux.org.uk>
	<B85A65D85D7EB246BE421B3FB0FBB593024DF05E85@dbde02.ent.ti.com>
Message-ID: <20110803181438.GD23953@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 03, 2011 at 10:49:21PM +0530, Nori, Sekhar wrote:
> And from what I read[1], it is futile to try and make v5 and v6 architectures
> build together.

Correct.  The differences are just too great.  We're going to hit the
same thing with LPAE too.

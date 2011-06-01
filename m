From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 1 Jun 2011 22:45:00 +0530
Subject: [PATCH V2] davinci: da850: move input frequency to board
	specific files
In-Reply-To: <1306488053-27978-1-git-send-email-christian.riesch@omicron.at>
References: <1306312622-4901-1-git-send-email-christian.riesch@omicron.at>
	<1306488053-27978-1-git-send-email-christian.riesch@omicron.at>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D2D22C1@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2011 at 14:50:53, Christian Riesch wrote:
> From: Bob Dunlop <bob.dunlop@xyzzy.org.uk>
> 
> Currently the input frequency of the SoC is hardcoded in the SoC specific
> da850.c file to 24 MHz. Since the SoC accepts input frequencies in a wide
> range from 12 to 50 MHz, boards with different oscillator/crystal
> frequencies may be built.

The same problem was fixed for dm6467/T EVMs with a different approach.

This solution is much better than what was done for dm6467/T.
So I am working on converting the dm6467/T code to this approach
and should be able to post the updated patchset by tomorrow.

Thanks,
Sekhar

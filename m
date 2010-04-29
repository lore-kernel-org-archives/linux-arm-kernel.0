From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 29 Apr 2010 09:45:35 +0200
Subject: [PATCH 1/4] MMC: atmel-mci: fix two parameters swapped
In-Reply-To: <20100428112245.23e99d70.akpm@linux-foundation.org>
References: <bfa27c51250b39deeccbf6f3a656db4e0b73ce92.1272378853.git.nicolas.ferre@atmel.com>	<bfa27c51250b39deeccbf6f3a656db4e0b73ce92.1272378853.git.nicolas.ferre@atmel.com>
	<20100428112245.23e99d70.akpm@linux-foundation.org>
Message-ID: <4BD9391F.6070707@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/04/2010 20:22, Andrew Morton :
> Patches 1-3 (at least) appear to be applicable to 2.6.33.x and perhaps
> earlier.

Correct.

> But you didn't cc stable at kernel.org and there was no Cc:
> <stable@kernel.org> in the changelog and in this case I'd prefer not to
> make that decision myself?

You are right. In fact I was waiting for feedback before pushing this
also to "stable"...

I keep this in mind and will do this when it will be merged in mainline.

Thanks, best regards,
-- 
Nicolas Ferre

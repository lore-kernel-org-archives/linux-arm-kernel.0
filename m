From: horms@verge.net.au (Simon Horman)
Date: Thu, 15 Feb 2018 18:03:56 +0100
Subject: [PATCH V2] ARM: shmobile: stout: enable R-Car Gen2 regulator quirk
In-Reply-To: <20180215100208.24646-1-marek.vasut+renesas@gmail.com>
References: <20180215100208.24646-1-marek.vasut+renesas@gmail.com>
Message-ID: <20180215170356.r63dmgt5umfirqlu@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 11:02:08AM +0100, Marek Vasut wrote:
> Regulator setup is suboptimal on H2 Stout too. The Stout newly has
> two DA9210 regulators, so the quirk is extended to handle another
> DA9210 at i2c address 0x70.

It looks like this patch has received some review that needs addressing.
I have marked it as "Changes Requested".

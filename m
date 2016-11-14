From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 14 Nov 2016 14:44:29 +0800
Subject: [PATCH] i.MX: Kconfig: Drop errata 769419 for Vybrid
In-Reply-To: <1478709850-9361-1-git-send-email-andrew.smirnov@gmail.com>
References: <1478709850-9361-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <20161114064426.GK3310@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 08:44:10AM -0800, Andrey Smirnov wrote:
> According to the datasheet, VF610 uses revision r3p2 of the L2C-310
> block, same as i.MX6Q+, which does not require a software workaround for
> ARM errata 769419.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

I updated subject prefix a bit and applied the patch.

Shawn

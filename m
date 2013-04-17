From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 17 Apr 2013 14:18:54 -0500
Subject: [PATCH] ARM: dts: omap4-panda: Add LED support into the panda
 DTS files
In-Reply-To: <1366225778-6083-2-git-send-email-dmurphy@ti.com>
References: <1366225778-6083-1-git-send-email-dmurphy@ti.com>
 <1366225778-6083-2-git-send-email-dmurphy@ti.com>
Message-ID: <516EF59E.3090907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 04/17/2013 02:09 PM, Dan Murphy wrote:
> The GPIO for LED D1 on the omap4-panda a1-a3 rev and the omap4-panda-es
> are different.
> 
> Abstract away the pinmux and the LED definitions for the two boards.

Just a heads-up but you should base this upon Benoit's for_3.10 branch
[1] as there is now a omap4-panda-common.dtsi where the led stuff
currently resides.

Cheers
Jon

[1]
http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.10/dts

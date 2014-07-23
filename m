From: olof@lixom.net (Olof Johansson)
Date: Wed, 23 Jul 2014 11:53:34 -0700
Subject: [PATCH v4 2/2] platform: Make platform_bus device a platform
 device
In-Reply-To: <1406135239-17550-2-git-send-email-pawel.moll@arm.com>
References: <1406135239-17550-1-git-send-email-pawel.moll@arm.com>
 <1406135239-17550-2-git-send-email-pawel.moll@arm.com>
Message-ID: <20140723185334.GA9531@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 06:07:19PM +0100, Pawel Moll wrote:
> ... describing the root of the device tree, so one can write
> a platform driver initializing the platform.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Ran it through the boot farm. Results at:

http://arm-soc.lixom.net/bootlogs/misc/v3.16-rc6-772-g7926904/

Tested-by: Olof Johansson <olof@lixom.net>

For when Greg is happy with this:

Acked-by: Olof Johansson <olof@lixom.net>


-Olof

From: kaloz@openwrt.org (Imre Kaloz)
Date: Tue, 20 Nov 2012 08:21:22 +0100
Subject: [PATCH] arm: orion5x: convert Netgear WNR854T to device tree
In-Reply-To: <20121119204641.GK22106@titan.lakedaemon.net>
References: <1353342451-27180-1-git-send-email-kaloz@openwrt.org>
 <20121119204641.GK22106@titan.lakedaemon.net>
Message-ID: <op.wn19dwpw2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Mon, 19 Nov 2012 21:46:41 +0100, Jason Cooper <jason@lakedaemon.net> wrote:

> On Mon, Nov 19, 2012 at 05:27:31PM +0100, Imre Kaloz wrote:
>> This commit converts the Netgear WNR854T to device tree
>>
>> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
>> ---
>>  arch/arm/boot/dts/Makefile                    |    3 +-
>>  arch/arm/boot/dts/orion5x-netgear-wnr854t.dts |   83 +++++++++++++++++++++++++
>>  arch/arm/mach-orion5x/Kconfig                 |    7 +-
>>  arch/arm/mach-orion5x/Makefile                |    2 +-
>>  arch/arm/mach-orion5x/board-dt.c              |    3 +
>>  arch/arm/mach-orion5x/common.h                |    5 ++
>>  arch/arm/mach-orion5x/wnr854t-setup.c         |   59 +-----------------
>>  7 files changed, 99 insertions(+), 63 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
>
> One last thing, could you use savedefconfig and update orion5x_defconfig
> to include your new board?  It can be a part of the same patch.

Would you prefer it to be included in this one or in a later patch if I'm done adding some more boards?


Thanks,

Imre

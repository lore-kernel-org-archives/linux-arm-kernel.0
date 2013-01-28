From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Jan 2013 14:04:04 -0800
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: remove unnecessary
 CONFIG_GPIOLIB
In-Reply-To: <bb37ce3392153c4cae3a2bc642f831683620473a.1359057921.git.josh.cartwright@ni.com>
References: <bb37ce3392153c4cae3a2bc642f831683620473a.1359057921.git.josh.cartwright@ni.com>
Message-ID: <20130128220404.GB7789@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 12:59:22PM -0600, Josh Cartwright wrote:
> Commit 38669e045dbf8f62a008898a7fb1e93975b3817c ("ARM: vexpress: Start
> using new Versatile Express infrastructure") introduces a hard
> dependency to GPIOLIB for the multi_v7_defconfig:
> 
>    ARCH_MULTI_V7 -> ARCH_VEXPRESS -> ARCH_REQUIRE_GPIOLIB -> GPIOLIB
> 
> Remove unnecessary explicit CONFIG_GPIOLIB=y from multi_v7_defconfig.
> 
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>


Applied, thanks.

-Olof

From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Sep 2015 16:31:38 -0700
Subject: [PATCH] arm-cci500: Don't enable PMU driver by default
In-Reply-To: <1443452244-14062-1-git-send-email-suzuki.poulose@arm.com>
References: <1443452244-14062-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20150928233138.GB30986@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2015 at 03:57:24PM +0100, Suzuki K. Poulose wrote:
> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> 
> Disable building CCI-500 PMU driver by default.
> 
> Reported-by: Russell King <linux@arm.linux.org.uk>
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: arm at kernel.org
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/bus/Kconfig |    1 -
>  1 file changed, 1 deletion(-)

Applied as fix for 4.3.


-Olof

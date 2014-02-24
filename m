From: mporter@linaro.org (Matt Porter)
Date: Mon, 24 Feb 2014 15:11:33 -0500
Subject: [PATCH v2] ARM: dts: Leave sdio1 as disabled on bcm28155-ap
In-Reply-To: <1391556460-24218-1-git-send-email-tim.kryger@linaro.org>
References: <1391556460-24218-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <20140224201133.GX5038@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 03:27:40PM -0800, Tim Kryger wrote:
> The sdio1 interface pins are routed to an unpopulated daughter card
> connector on the bcm28155-ap board.  Thus there is no need to mark
> this interface as enabled.
> 
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>

Applied to mach-bcm armsoc/for-3.15/dt

-Matt

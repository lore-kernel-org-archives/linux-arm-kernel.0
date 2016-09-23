From: will.deacon@arm.com (Will Deacon)
Date: Fri, 23 Sep 2016 17:27:56 +0100
Subject: [PATCH v6 2/4] arm64: dts: Add timer erratum property for
 LS2080A and LS1043A
In-Reply-To: <1474533318-7796-2-git-send-email-oss@buserror.net>
References: <1474533318-7796-1-git-send-email-oss@buserror.net>
 <1474533318-7796-2-git-send-email-oss@buserror.net>
Message-ID: <20160923162755.GG6397@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2016 at 03:35:16AM -0500, Scott Wood wrote:
> Signed-off-by: Scott Wood <oss@buserror.net>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 1 +
>  2 files changed, 2 insertions(+)

This patch conflicts with mainline, but I've queued the other three
patches in the series in the arm64 tree.

Please send the updated .dts changes via arm-soc.

Will

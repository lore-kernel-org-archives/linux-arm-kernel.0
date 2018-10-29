From: horms@verge.net.au (Simon Horman)
Date: Mon, 29 Oct 2018 11:39:13 +0100
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77990: Add SCIF-{0,1,3,4,5}
 device nodes
In-Reply-To: <1540071000-27091-1-git-send-email-ykaneko0929@gmail.com>
References: <1540071000-27091-1-git-send-email-ykaneko0929@gmail.com>
Message-ID: <20181029103905.4wkgxabyylguzmou@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 21, 2018 at 06:30:00AM +0900, Yoshihiro Kaneko wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> This patch adds the device nodes for SCIF-{0,1,3,4,5} serial ports to
> the R8A77990 SoC.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Thanks.

I don't believe this can (easily) be tested as SCIF-{0,1,3,4,5}
do not appear to be exposed on the Ebisu board.

I have checked this patch with reference to the documentation
and it looks good to me. I have applied if for v4.21.

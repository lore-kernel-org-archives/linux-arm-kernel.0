From: horms@verge.net.au (Simon Horman)
Date: Mon, 5 Nov 2018 16:42:03 +0100
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77990: Add all HSCIF nodes
In-Reply-To: <1540071027-27130-1-git-send-email-ykaneko0929@gmail.com>
References: <1540071027-27130-1-git-send-email-ykaneko0929@gmail.com>
Message-ID: <20181105154202.bchgx2yxnmjxygte@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 21, 2018 at 06:30:27AM +0900, Yoshihiro Kaneko wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> This patch adds the device nodes for all HSCIF serial ports to
> the R8A77990 SoC.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
> 
> This patch is based on the devel branch of Simon Horman's renesas tree.

Thanks.

I don't believe this can (easily) be tested as HSCIF
does not appear to be exposed on the Ebisu board.

I have checked this patch with reference to the documentation
and it looks good to me. I have applied if for v4.21.

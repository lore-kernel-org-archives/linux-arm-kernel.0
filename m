From: agross@codeaurora.org (Andy Gross)
Date: Tue, 8 Dec 2015 17:01:27 -0600
Subject: [PATCH] ARM: defconfig: qcom: Enable SSBI drivers
In-Reply-To: <20151208225429.GA12111@Agamemnon.attlocal.net>
References: <1448932137-12717-1-git-send-email-sboyd@codeaurora.org>
 <20151208225429.GA12111@Agamemnon.attlocal.net>
Message-ID: <20151208230127.GB12111@Agamemnon.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 04:54:29PM -0600, Andy Gross wrote:
> On Mon, Nov 30, 2015 at 05:08:57PM -0800, Stephen Boyd wrote:
> > Enable some ssbi drivers present on msm8660, msm8960 and apq8064
> > devices so that we fully exercise the devices present in the dts
> > files.
> > 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> Acked-by: Andy Gross <andy.gross@codeaurora.org>

Arnd, Olof, Kevin,

Can you guys pick this up.  This patch is based off the earlier qcom_defconfig
that was merged through the arm-soc directly.

Thanks.

From: agross@codeaurora.org (Andy Gross)
Date: Tue, 8 Dec 2015 16:54:29 -0600
Subject: [PATCH] ARM: defconfig: qcom: Enable SSBI drivers
In-Reply-To: <1448932137-12717-1-git-send-email-sboyd@codeaurora.org>
References: <1448932137-12717-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20151208225429.GA12111@Agamemnon.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 05:08:57PM -0800, Stephen Boyd wrote:
> Enable some ssbi drivers present on msm8660, msm8960 and apq8064
> devices so that we fully exercise the devices present in the dts
> files.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Andy Gross <andy.gross@codeaurora.org>

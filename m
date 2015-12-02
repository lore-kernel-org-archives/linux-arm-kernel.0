From: agross@codeaurora.org (Andy Gross)
Date: Tue, 1 Dec 2015 18:02:42 -0600
Subject: [PATCH] ARM: defconfig: multi_v7: Enable Qualcomm options for
 Honami
In-Reply-To: <1449010070-9796-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1448518557-14250-1-git-send-email-agross@codeaurora.org>
 <1449010070-9796-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20151202000242.GB30950@Agamemnon.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 02:47:50PM -0800, Bjorn Andersson wrote:
> The Honami device does not boot due to the lack of pinctrl support
> compiled in with the multi_v7_defconfig. This patch correct this and
> enables coincell, sdhci, smsm, smp2p and wcnss_ctrl as well, all found
> on a variety of Qualcomm boards.
> 
> Reported-by: Kevin Hilman <khilman@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---

That would make a difference, wouldn't it.

Acked-by: Andy Gross <agross@codeaurora.org>

From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 01 Dec 2015 16:26:49 -0800
Subject: [PATCH] ARM: defconfig: multi_v7: Enable Qualcomm options for
 Honami
In-Reply-To: <1449010070-9796-1-git-send-email-bjorn.andersson@sonymobile.com>
 (Bjorn Andersson's message of "Tue, 1 Dec 2015 14:47:50 -0800")
References: <1449010070-9796-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <7hd1up66gm.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bjorn Andersson <bjorn.andersson@sonymobile.com> writes:

> The Honami device does not boot due to the lack of pinctrl support
> compiled in with the multi_v7_defconfig. This patch correct this and
> enables coincell, sdhci, smsm, smp2p and wcnss_ctrl as well, all found
> on a variety of Qualcomm boards.
>
> Reported-by: Kevin Hilman <khilman@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Tested-by: Kevin Hilman <khilman@linaro.org>

Verified that this patch on top of next-20151127 gets my z1 booting
again.

Kevin

From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Apr 2014 16:53:13 +0200
Subject: [PATCH 3/4] pinctrl: tegra: reduce size of data table fields
In-Reply-To: <1397511222-28533-3-git-send-email-swarren@wwwdotorg.org>
References: <1397511222-28533-1-git-send-email-swarren@wwwdotorg.org>
 <1397511222-28533-3-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CACRpkda=_tAp6SQWTe33CcxU26=gD7cVwdw_CKPPt+ejA5T5qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 11:33 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> From: Stephen Warren <swarren@nvidia.com>
>
> The range of npins and function ID values is small enough to fit into a
> u8. Use this type rather than unsigned to shrink the pinmux data tables.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied with Laxman's ACK.

Yours,
Linus Walleij

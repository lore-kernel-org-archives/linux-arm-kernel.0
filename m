From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Sep 2013 11:52:24 -0600
Subject: [PATCH 03/12] clk: tegra: Add TEGRA_PERIPH_NO_DIV flag
In-Reply-To: <1379515331-19427-4-git-send-email-pdeschrijver@nvidia.com>
References: <1379515331-19427-1-git-send-email-pdeschrijver@nvidia.com>
 <1379515331-19427-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <52407FD8.3020509@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 08:40 AM, Peter De Schrijver wrote:
> This flag indicates the peripheral clock does not have a divider. It will
> simply the initialization tables and avoids some very similar code.

s/simply/simplify/

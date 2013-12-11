From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 11 Dec 2013 09:28:22 +0000
Subject: [PATCH 2/8] mfd: ssbi: Constify buffer in ssbi_write
In-Reply-To: <1386718523-2587-3-git-send-email-sboyd@codeaurora.org>
References: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
 <1386718523-2587-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20131211092822.GE16780@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Dec 2013, Stephen Boyd wrote:

> In preparation for passing a const pointer directly to
> ssbi_write() from the regmap APIs.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/mfd/ssbi.c   | 8 ++++----
>  include/linux/ssbi.h | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

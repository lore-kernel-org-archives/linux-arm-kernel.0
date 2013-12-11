From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 11 Dec 2013 09:29:42 +0000
Subject: [PATCH 4/8] mfd: ssbi: Mark match table const
In-Reply-To: <1386718523-2587-5-git-send-email-sboyd@codeaurora.org>
References: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
 <1386718523-2587-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <20131211092942.GF16780@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Dec 2013, Stephen Boyd wrote:

> This is a read-only data structure.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/mfd/ssbi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It certainly is.

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

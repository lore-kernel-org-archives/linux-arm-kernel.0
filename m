From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 11 Dec 2013 09:27:24 +0000
Subject: [PATCH 1/8] mfd: ssbi: Remove platform data structs and hide
 ssbi type enum
In-Reply-To: <1386718523-2587-2-git-send-email-sboyd@codeaurora.org>
References: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
 <1386718523-2587-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20131211092724.GD16780@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Dec 2013, Stephen Boyd wrote:

> The ssbi driver assumes that the device is DT based. Remove the
> platform data structs that will never be used and hide the enum
> in the only C file that uses it.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/mfd/ssbi.c   |  6 ++++++
>  include/linux/ssbi.h | 17 +----------------
>  2 files changed, 7 insertions(+), 16 deletions(-)

I don't see any uses of the aforementioned struct.

Patch applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sun, 1 May 2016 14:01:46 -0700
Subject: [PATCH 08/12] nvmem: mtk-efuse: remove nvmem regmap dependency
In-Reply-To: <1461526096-29584-9-git-send-email-srinivas.kandagatla@linaro.org>
References: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1461526096-29584-9-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20160501210146.GA29070@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 24, 2016 at 08:28:12PM +0100, Srinivas Kandagatla wrote:
> This patch moves to nvmem support in the driver to use callback
> instead of regmap.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Acked-by: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
> ---
>  drivers/nvmem/Kconfig     |  1 -
>  drivers/nvmem/mtk-efuse.c | 47 ++++++++++++++++++++++++++++++++---------------
>  2 files changed, 32 insertions(+), 16 deletions(-)

This patch didn't apply to my tree.  Can you fix it up and resend, and
also patch 11/12?

thanks,

greg k-h

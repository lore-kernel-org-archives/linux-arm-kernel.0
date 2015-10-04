From: gregkh@linuxfoundation.org (Greg KH)
Date: Sun, 4 Oct 2015 12:04:21 +0100
Subject: [PATCH 4/4] nvmem: sunxi: Check for memory allocation failure
In-Reply-To: <1443616591-17867-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1443616298-17389-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1443616591-17867-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20151004110421.GB7110@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 01:36:31PM +0100, Srinivas Kandagatla wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> The sunxi_sid driver doesn't check for kmalloc return status before
> derefencing the returned pointer, which could lead to a NULL pointer
> dereference if kmalloc failed. Check for its return code to make sure it
> deosn't happen.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/nvmem/sunxi_sid.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

No signed-off-by: from you on this patch?

:(

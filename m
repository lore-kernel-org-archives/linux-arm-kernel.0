From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 13 Jan 2017 08:15:45 +0100
Subject: [PATCH v2 18/18] insert build break
In-Reply-To: <1484260655-80477-1-git-send-email-christopher.lee.bostic@gmail.com>
References: <1484260655-80477-1-git-send-email-christopher.lee.bostic@gmail.com>
Message-ID: <20170113071545.GB12441@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2017 at 04:37:35PM -0600, christopher.lee.bostic at gmail.com wrote:
> From: Chris Bostic <cbostic@us.ibm.com>
> 
> Signed-off-by: Chris Bostic <cbostic@us.ibm.com>

I can not accept patches that have no changelog text, and this one is
very odd:

> ---
>  drivers/fsi/fsi-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index 28b82d1..db09836 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -42,6 +42,7 @@
>  
>  static DEFINE_IDA(master_ida);
>  
> +

Huh?

Did something go wrong with your scripts?

greg k-h

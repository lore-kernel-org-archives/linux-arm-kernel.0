From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 3 Jun 2017 17:41:26 +0900
Subject: [PATCH 01/10] staging: fsl-mc: enclose macro params in parens
In-Reply-To: <20170531105852.22304-2-laurentiu.tudor@nxp.com>
References: <20170531105852.22304-1-laurentiu.tudor@nxp.com>
 <20170531105852.22304-2-laurentiu.tudor@nxp.com>
Message-ID: <20170603084126.GB10784@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 31, 2017 at 01:58:43PM +0300, laurentiu.tudor at nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Several macros didn't had macro params enclosed
> in parens. Fix them to avoid precedence issues.
> 
> Found with checkpatch.pl who was issuing this
> message:
>   "Macro argument 'id' may be better as '(id)'
>    to avoid precedence issues"

Why are you line-wrapping at such a small number?  Please use 72 columns
like git asks you to...

thanks,

greg k-h

From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 9 Apr 2013 12:05:10 +0200
Subject: [PATCH 1/2] mfd: db8500-prcmu: Return early if the TCPM cannot
 be located
In-Reply-To: <1365071941-23475-1-git-send-email-lee.jones@linaro.org>
References: <1365071941-23475-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20130409100510.GP24058@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Thu, Apr 04, 2013 at 11:39:00AM +0100, Lee Jones wrote:
> Currently we check to see if we obtained the Tightly Coupled Program
> Memory (TCPM) base and only execute the code within the check if we
> have it. It's more traditional to return early if we don't have it.
> This way we can flatten most of the function's code down to a single
> tab spacing.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/db8500-prcmu.c |   40 +++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
I had to apply this one manually, please check if it was done correctly from
my mfd-next tree.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

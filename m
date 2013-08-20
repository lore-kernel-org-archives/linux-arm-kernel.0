From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 20 Aug 2013 03:43:21 +0200
Subject: [PATCH] mfd: dbx500: Remove any mention of the BML8580CLK
In-Reply-To: <1376912313-26512-1-git-send-email-lee.jones@linaro.org>
References: <1376912313-26512-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20130820014321.GH13324@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, Aug 19, 2013 at 12:38:33PM +0100, Lee Jones wrote:
> The platform which it pertains to is no longer supported and is actually
> causing some confusion in the new common clock implementation. A recent
> patch removed its use in the clock driver, let's take out the definitions
> too.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

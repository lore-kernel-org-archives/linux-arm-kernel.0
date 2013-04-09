From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 9 Apr 2013 22:55:04 +0200
Subject: [PATCH 2/2 v2] mfd: db8500-prcmu: Support platform dependant
 device selection
In-Reply-To: <20130409195258.GH25316@gmail.com>
References: <1365071941-23475-1-git-send-email-lee.jones@linaro.org>
 <1365071941-23475-2-git-send-email-lee.jones@linaro.org>
 <20130409195258.GH25316@gmail.com>
Message-ID: <20130409205504.GC24058@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Tue, Apr 09, 2013 at 08:52:58PM +0100, Lee Jones wrote:
> The main aim for this cycle is to have the u8540 booting to a
> console. However, the u8540 doesn't support all of the u8500
> platform devices yet. After this stage is complete we can then
> fill in the inadequacies, such as specific clock support at a
> later date. To achieve this we're placing devices supported by
> all platforms into a common device structure and the remaining
> ones into a platform specific one.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/db8500-prcmu.c |   32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
Applied and pushed now, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

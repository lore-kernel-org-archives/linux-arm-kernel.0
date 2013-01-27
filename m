From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 28 Jan 2013 00:54:05 +0100
Subject: [PATCH 26/26] mfd: ab8500-gpadc: Use new ab8500_gpadc_get() with
 name parameter
In-Reply-To: <1358254566-12419-27-git-send-email-lee.jones@linaro.org>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
 <1358254566-12419-27-git-send-email-lee.jones@linaro.org>
Message-ID: <20130127235405.GU1174@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Tue, Jan 15, 2013 at 12:56:06PM +0000, Lee Jones wrote:
> From: Philippe Langlais <philippe.langlais@linaro.org>
> 
> The new format of ab8500_gpadc_get() accepts a device name as a
> parameter to specify which device to retrieve. This patch
> enforces the use of that new format.
Where is that new API coming from ? I couldn't find it in the previous 25
patches. If it's there, this one should be merged with the patch that changes
this API.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

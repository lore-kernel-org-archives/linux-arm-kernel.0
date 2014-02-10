From: Ying.Liu@freescale.com (Liu Ying)
Date: Mon, 10 Feb 2014 18:42:57 +0800
Subject: [PATCH] staging: drm/imx: remove an unnecessary local variable
In-Reply-To: <20140210102906.GP26684@n2100.arm.linux.org.uk>
References: <1392028185-4528-1-git-send-email-Ying.Liu@freescale.com>
 <20140210102906.GP26684@n2100.arm.linux.org.uk>
Message-ID: <52F8AD31.4000109@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2014 06:29 PM, Russell King - ARM Linux wrote:
> On Mon, Feb 10, 2014 at 06:29:45PM +0800, Liu Ying wrote:
>> This patch removes an unnecessary local variable defined
>> in the function imx_drm_driver_unload() so as to fix the
>> following build warning.
>>
>> drivers/staging/imx-drm/imx-drm-core.c: \
>> In function ?imx_drm_driver_unload?:
>> drivers/staging/imx-drm/imx-drm-core.c:87:25: \
>> warning: unused variable ?imxdrm? [-Wunused-variable]
> 
> Already-Naked-by: me.  This is required by later patches in the series
> posted earlier.
> 

Sorry. Did you mean that you have already got a fix for this?

From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 10 Jan 2018 11:18:40 +0100
Subject: [PATCH linux dev-4.10 3/6] drivers/misc: Add driver for Aspeed
 PECI and generic PECI headers
In-Reply-To: <20180109223126.13093-4-jae.hyun.yoo@linux.intel.com>
References: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
 <20180109223126.13093-4-jae.hyun.yoo@linux.intel.com>
Message-ID: <20180110101840.GB5822@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 02:31:23PM -0800, Jae Hyun Yoo wrote:
> This commit adds driver implementation for Aspeed PECI. Also adds
> generic peci.h and peci_ioctl.h files to provide compatibility
> to peci drivers that can be implemented later e.g. Nuvoton's BMC
> SoC family.

We don't add code that could be used "sometime in the future".  Only
include stuff that we use now.

Please fix up this series based on that and resubmit.  There should not
be any need for any uapi file then, right?

thanks,

greg k-h

From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Wed, 10 Jan 2018 11:32:53 -0800
Subject: [PATCH linux dev-4.10 3/6] drivers/misc: Add driver for Aspeed
 PECI and generic PECI headers
In-Reply-To: <20180110101840.GB5822@kroah.com>
References: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
 <20180109223126.13093-4-jae.hyun.yoo@linux.intel.com>
 <20180110101840.GB5822@kroah.com>
Message-ID: <0a87954e-f49c-bcd8-5aa9-65f0dc02e851@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/10/2018 2:18 AM, Greg KH wrote:
> On Tue, Jan 09, 2018 at 02:31:23PM -0800, Jae Hyun Yoo wrote:
>> This commit adds driver implementation for Aspeed PECI. Also adds
>> generic peci.h and peci_ioctl.h files to provide compatibility
>> to peci drivers that can be implemented later e.g. Nuvoton's BMC
>> SoC family.
> 
> We don't add code that could be used "sometime in the future".  Only
> include stuff that we use now.
> 
> Please fix up this series based on that and resubmit.  There should not
> be any need for any uapi file then, right?
> 
> thanks,
> 
> greg k-h
> 

These header files are being used in this patch set as well. I meant, 
these files also can be used for the future implementation to provide 
compatibility. I will update the commit message.

Thanks,
Jae

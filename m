From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Wed, 10 Jan 2018 11:14:34 -0800
Subject: [PATCH linux dev-4.10 0/6] Add support PECI and PECI hwmon drivers
In-Reply-To: <20180110101755.GA5822@kroah.com>
References: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
 <20180110101755.GA5822@kroah.com>
Message-ID: <006c4a95-9299-bd17-6dec-52578e8461ae@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/10/2018 2:17 AM, Greg KH wrote:
> On Tue, Jan 09, 2018 at 02:31:20PM -0800, Jae Hyun Yoo wrote:
>> From: Jae Hyun Yoo <jae.hyun.yoo@intel.com>
>>
>> Hello,
>>
>> This patch set provides support for PECI of AST2400/2500 which can give us PECI
>> functionalities such as temperature monitoring, platform manageability,
>> processor diagnostics and failure analysis. Also provides generic peci.h and
>> peci_ioctl.h headers to provide compatibility to peci drivers that can be
>> implemented later e.g. Nuvoton's BMC SoC family.
> 
> What is the "dev-4.10" in the subject for?  4.10 is really old and
> obsolete :(
> 
> thanks,
> 
> greg k-h
> 

I made this patch set on top of the v4.10 which OpenBmc project is 
currently using. I'll rebase this patch set onto the current kernel.org 
mainline.

Thanks,
Jae

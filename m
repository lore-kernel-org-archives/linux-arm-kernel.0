From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Wed, 10 Jan 2018 11:30:05 -0800
Subject: [PATCH linux dev-4.10 0/6] Add support PECI and PECI hwmon drivers
In-Reply-To: <20180110191703.GA20248@kroah.com>
References: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
 <20180110101755.GA5822@kroah.com>
 <006c4a95-9299-bd17-6dec-52578e8461ae@linux.intel.com>
 <20180110191703.GA20248@kroah.com>
Message-ID: <8997e43c-683e-418d-4e2b-1fe3fefe254e@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/10/2018 11:17 AM, Greg KH wrote:
> On Wed, Jan 10, 2018 at 11:14:34AM -0800, Jae Hyun Yoo wrote:
>> On 1/10/2018 2:17 AM, Greg KH wrote:
>>> On Tue, Jan 09, 2018 at 02:31:20PM -0800, Jae Hyun Yoo wrote:
>>>> From: Jae Hyun Yoo <jae.hyun.yoo@intel.com>
>>>>
>>>> Hello,
>>>>
>>>> This patch set provides support for PECI of AST2400/2500 which can give us PECI
>>>> functionalities such as temperature monitoring, platform manageability,
>>>> processor diagnostics and failure analysis. Also provides generic peci.h and
>>>> peci_ioctl.h headers to provide compatibility to peci drivers that can be
>>>> implemented later e.g. Nuvoton's BMC SoC family.
>>>
>>> What is the "dev-4.10" in the subject for?  4.10 is really old and
>>> obsolete :(
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>
>> I made this patch set on top of the v4.10 which OpenBmc project is currently
>> using. I'll rebase this patch set onto the current kernel.org mainline.
> 
> What is "OpenBmc", and why are they using an obsolete and insecure
> kernel for their project?  That seems like a very foolish thing to do...
> 
> thanks,
> 
> greg k-h
> 

OpenBmc is an open source project to create a highly extensible 
framework for BMC (Board Management Controller) software for data-center 
computer systems:
https://github.com/openbmc

Its current mainline is v4.10 but it is being kept upgrading so it will 
be upgraded to the latest stable or long-term version soon.

Thanks,
Jae

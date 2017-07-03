From: xuwei5@hisilicon.com (Wei Xu)
Date: Mon, 3 Jul 2017 14:32:24 +0100
Subject: [PATCH v11 0/3]add PCIe driver for Kirin PCIe
In-Reply-To: <CAFGCpxx+92PSs1VaryFOXau7CjBYEP4H6wT-o=bNMwkSznjQuw@mail.gmail.com>
References: <20170619102349.50652-1-songxiaowei@hisilicon.com>
 <20170702233657.GA13507@bhelgaas-glaptop.roam.corp.google.com>
 <20170703104727.GB1573@arm.com>
 <CAFGCpxx+92PSs1VaryFOXau7CjBYEP4H6wT-o=bNMwkSznjQuw@mail.gmail.com>
Message-ID: <595A4768.20404@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guodong,

On 2017/7/3 14:04, Guodong Xu wrote:
> Hi, Xu Wei
> 
> 
> 
> On Mon, Jul 3, 2017 at 6:47 PM, Will Deacon <will.deacon@arm.com> wrote:
>> On Sun, Jul 02, 2017 at 06:36:57PM -0500, Bjorn Helgaas wrote:
>>> [+cc Catalin, Will, linux-arm-kernel]
>>>
>>> Applied patches 2 & 3 to pci/host-kirin for v4.13.
>>>
>>> I would like a MAINTAINERS update, too.  If you send me that, I'll
>>> squash it into the driver patch.
>>>
>>> Catalin, Will, how do you want to handle the
>>> arch/arm64/configs/defconfig change (patch 3)?  It's currently on my
>>> branch, but I'm happy to drop it if another route is better.
>>
>> defconfig updates usually go through arm-soc, via the relevant platform
>> maintainer, so it would be best to follow that route here too otherwise
>> you'll probably see conflicts in -next.
>>
> 
> Is it ok for you to pick up the arch/arm64/configs/defconfig change (patch 3)?

Since it is already 4.12-rc7, I will pick up it and queue for the v4.14.
Are you fine about that?
Thanks!

Best Regards,
Wei

> 
> -Guodong
> 
>> Will
> 
> .
> 

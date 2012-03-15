From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 15 Mar 2012 17:38:12 +0000
Subject: [PATCH 2/5] MMC: mmci: Seperate ARM variants from generic code
In-Reply-To: <4F622884.6060807@linaro.org>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
 <1331734803-17954-3-git-send-email-lee.jones@linaro.org>
 <20120315173256.GD15988@n2100.arm.linux.org.uk> <4F622884.6060807@linaro.org>
Message-ID: <4F622904.4000705@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/03/12 17:36, Lee Jones wrote:
> On 15/03/12 17:32, Russell King - ARM Linux wrote:
>> On Wed, Mar 14, 2012 at 02:20:00PM +0000, Lee Jones wrote:
>>> This is a step in the right direction for future Device
>>> Tree support. It will allow variant specific attributes
>>> to be collected from a Device Tree without overloading
>>> the MMCI core. It will also provide additional future
>>> variants a cleaner way to add support.
>>
>> NAK.  You can't have two driver structures with the same name.  The names
>> are sysfs object names.
> 
> Well spotted.
> 
> I've already changed this in v2. :)

In case you were interested, see:

http://git.linaro.org/gitweb?p=people/ljones/linux-3.0-ux500.git;a=shortlog;h=refs/heads/device-tree-snowball-mmci

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

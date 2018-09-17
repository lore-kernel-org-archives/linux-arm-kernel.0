From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 17 Sep 2018 11:56:08 +0200
Subject: [PATCH v2 2/4] iio: Documentation: Add Xilinx AMS sysfs
 documentation
In-Reply-To: <20180916111242.73af71ed@archlinux>
References: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
 <1536909510-7166-3-git-send-email-manish.narani@xilinx.com>
 <20180916111242.73af71ed@archlinux>
Message-ID: <cf2acc8a-ed2d-27f4-ca58-3e2132e17d2a@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.9.2018 12:12, Jonathan Cameron wrote:
> On Fri, 14 Sep 2018 12:48:28 +0530
> Manish Narani <manish.narani@xilinx.com> wrote:
> 
>> Add documentation for xilinx-ams driver. This contains information about
>> various voltages and temperatures on PS (Processing System), PL
>> (Programmable Logic) and AMS Control Block.
>>
>> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> The more I look at this device the more I'm convinced it is very much a dedicated
> hardware monitoring function, not a generic ADC sensing unit at all.
> 
> Hmm.  It is still fine to have it in IIO but you need to think in detail
> about how you are going to interface this to hwmon via the iio-hwmon bridge.
> 
> Some of the interface complexity should only really be apparent when we hit
> hwmon perhaps rather than having so many different custom interfaces in IIO.
> 
> Please also loop in the maintainers and lists for hwmon in the next
> version so we can get their input.

Isn't there iio-hwmon driver for this?

Thanks,
Michal

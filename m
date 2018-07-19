From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 19 Jul 2018 10:22:07 +0200
Subject: [PATCH 1/4] iio: adc: xilinx: Rename 'channels' variable name to
 'iio_xadc_channels'
In-Reply-To: <d2c3ddfd-91da-e500-7b58-917d2da1d540@metafoo.de>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
 <1531912331-26431-2-git-send-email-manish.narani@xilinx.com>
 <d2c3ddfd-91da-e500-7b58-917d2da1d540@metafoo.de>
Message-ID: <7c4ee0db-ac33-b093-4dbb-1742fb029012@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.7.2018 13:18, Lars-Peter Clausen wrote:
> On 07/18/2018 01:12 PM, Manish Narani wrote:
>> This patch fix the following checkpatch warning in xadc driver.
>> - Reusing the krealloc arg is almost always a bug.
>>
>> Renamed the 'channels' variable as 'iio_xadc_channels' to fix the above
>> warning.
>>
> 
> This is a bug in checkpatch and should be fixed in checkpatch. The code is
> not actually re-using the parameter. channels and xadc_channels are
> independent variables, just checkpatch somehow does not realize this.

I think it should be fine to have this patch in tree. Change in commit
message to reflect this should be enough. But that's just view.

Thanks,
Michal

From: rjui@broadcom.com (Ray Jui)
Date: Mon, 9 Feb 2015 21:23:38 -0800
Subject: [PATCH v9 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <20150209121036.GB2491@katana>
References: <rjui@broadcom.com>
 <1423373126-30024-1-git-send-email-rjui@broadcom.com>
 <1423373126-30024-3-git-send-email-rjui@broadcom.com>
 <20150209121036.GB2491@katana>
Message-ID: <54D995DA.7040201@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2/9/2015 4:10 AM, Wolfram Sang wrote:
> On Sat, Feb 07, 2015 at 09:25:25PM -0800, Ray Jui wrote:
>> Add initial support to the Broadcom iProc I2C controller found in the
>> iProc family of SoCs.
>>
>> The iProc I2C controller has separate internal TX and RX FIFOs, each has
>> a size of 64 bytes. The iProc I2C controller supports two bus speeds
>> including standard mode (100kHz) and fast mode (400kHz)
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> Reviewed-by: Kevin Cernekee <cernekee@chromium.org>
> 
> Applied to for-next, thanks!
> 
> Next time, please send new patches as seperate threads, not as a reply
> to the old series.
> 

Thanks, Wolfram. I think I'm missing something here and would like to
get it clarified, so I don't make the same mistake again in the future:
I thought I've already sent these patches as a new thread, i.e., [PATCH
v9 ...], isn't it?

Thanks,

Ray

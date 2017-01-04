From: scott.branden@broadcom.com (Scott Branden)
Date: Wed, 4 Jan 2017 10:47:09 -0800
Subject: [PATCH 2/2] mmc: sdhci-iproc: Increase max_blk_size for bcm2835
In-Reply-To: <87o9zonhoz.fsf@eliezer.anholt.net>
References: <1483111474-29907-1-git-send-email-stefan.wahren@i2se.com>
 <1483111474-29907-3-git-send-email-stefan.wahren@i2se.com>
 <87o9zonhoz.fsf@eliezer.anholt.net>
Message-ID: <046f69e9-f84c-fbdc-755a-694b6174e90f@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17-01-03 10:04 AM, Eric Anholt wrote:
> Stefan Wahren <stefan.wahren@i2se.com> writes:
>
>> According to the BCM2835 datasheet the maximum block size for the
>> eMMC module is restricted to the internal data FIFO which is 1024 byte.
>> But this is still an improvement to the default of 512 byte.
>
> Confirmed that the internal FIFOs are 1k.
>
> Reviewed-by: Eric Anholt <eric@anholt.net>
>
Acked-by: Scott Branden <scott.branden@broadcom.com>

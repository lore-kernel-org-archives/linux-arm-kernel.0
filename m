From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 23 Jan 2017 20:47:26 +0530
Subject: [PATCH RESEND 2/2] ARM: da850: add the nand dev_id to the clock
 lookup table
In-Reply-To: <0650f8ff-07f7-db06-ca3c-84eed7edb24e@ti.com>
References: <1484301626-30345-1-git-send-email-bgolaszewski@baylibre.com>
 <1484301626-30345-3-git-send-email-bgolaszewski@baylibre.com>
 <0650f8ff-07f7-db06-ca3c-84eed7edb24e@ti.com>
Message-ID: <8052f538-8573-c362-129c-a2ca6a64850e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 January 2017 07:16 PM, Sekhar Nori wrote:
> On Friday 13 January 2017 03:30 PM, Bartosz Golaszewski wrote:
>> The aemif driver can now access struct of_dev_auxdata (using platform
>> data).
>>
>> Add the device id to the clock lookup table for the nand clock and
>> create a separate lookup table for aemif subnodes.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Applied to v4.11/soc

I forgot that this has a build dependency with 1/2. Instead of creating
a dependency with Greg's tree, I think I will send it for v4.12. This is
a clean-up and does not add a new feature from a user's perspective so I
hope thats okay.

Thanks,
Sekhar

From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Wed, 14 Nov 2012 18:39:37 +0530
Subject: [PATCHv3 0/7] i2c: omap: updates
In-Reply-To: <20121114120400.GH5954@pengutronix.de>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
 <20121114120400.GH5954@pengutronix.de>
Message-ID: <50A39811.9030406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 November 2012 05:34 PM, Wolfram Sang wrote:
> On Mon, Nov 05, 2012 at 05:53:35PM +0530, Shubhrajyoti D wrote:
>
>> Shubhrajyoti D (8):
>>       i2c: omap: Fix the revision register read
>>       i2c: omap: use revision check for OMAP_I2C_FLAG_APPLY_ERRATA_I207
>>       i2c: omap: remove the dtrev
>>       ARM: i2c: omap: Remove the i207 errata flag
>>       i2c: omap: re-factor omap_i2c_init function
>>       i2c: omap: make reset a seperate function
>>       i2c: omap: Restore i2c context always
>>       i2c: omap: cleanup the sysc write
> Pushed the series to for-next, after fixing a trivial merge conflict
> caused by reverting the QoS patch.

Thanks.
>

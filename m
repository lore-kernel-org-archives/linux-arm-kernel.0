From: josh.wu@atmel.com (Josh Wu)
Date: Sun, 22 Sep 2013 11:52:35 +0800
Subject: [PATCH v3] mtd: atmel_nand: use minimum ecc requirements of nand:
 ecc_{strength,step}_ds
In-Reply-To: <20130919224154.GT4550@ld-irv-0074.broadcom.com>
References: <1379483928-18253-1-git-send-email-josh.wu@atmel.com>
 <20130918214225.GP4550@ld-irv-0074.broadcom.com>
 <20130919224154.GT4550@ld-irv-0074.broadcom.com>
Message-ID: <523E6983.3030203@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Brian

On 9/20/2013 6:41 AM, Brian Norris wrote:
> On Wed, Sep 18, 2013 at 02:42:25PM -0700, Brian Norris wrote:
>> On Wed, Sep 18, 2013 at 01:58:48PM +0800, Josh Wu wrote:
>>> Since ecc_{strength,step}_ds is introduced in nand_chip structure for
>>> minimum ecc requirements. So we can use them directly and remove our
>>> own get_onfi_ecc_param function.
>>>
>>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ...
>> I'll just apply the appended diff, to address these small comments and
>> to shorten the messages a little (they are a bit verbose and are over 80
>> characters). It's still not under 80, but it's more reasonable.
>>
>> Let me know if you have any objections, or else I'll push this to
>> l2-mtd.git.

Just back to office, no objections of cause and thank you for the 
modification to fix my typos and sentence.

> Pushed to l2-mtd.git. Thanks!
>
> Brian

Best Regards,
Josh Wu

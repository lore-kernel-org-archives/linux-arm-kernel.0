From: linux@prisktech.co.nz (Tony Prisk)
Date: Sun, 16 Jun 2013 09:58:53 +1200
Subject: [PATCH v3] i2c: vt8500: Add support for I2C bus on Wondermedia
 SoCs
In-Reply-To: <20130615111817.GA2938@katana>
References: <1371246736-5460-1-git-send-email-linux@prisktech.co.nz>
 <20130615111817.GA2938@katana>
Message-ID: <51BCE39D.4030505@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/06/13 23:18, Wolfram Sang wrote:
> On Sat, Jun 15, 2013 at 09:52:16AM +1200, Tony Prisk wrote:
>> This patch adds support for the I2C bus controllers found on Wondermedia
>> 8xxx-series SoCs. Only master-mode is supported.
>>
>> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
>> ---
> ...
>
>> +/* REG_TR */
>> +#define SCL_TIMEOUT(x)		(((x) & 0xFF) << 16)
> I assume this should be << 8 since all regs are 16 bit wide.
>
> Fixed it locally and ready to apply. Please confirm or send a proper
> fix. Rest looks fine.
>
> Thanks for the submission!
>
It should be << 8. Please apply your locally corrected version.

Regards
Tony Prisk

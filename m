From: robin@protonic.nl (Robin van der Gracht)
Date: Fri, 10 Feb 2012 08:58:48 +0100
Subject: mfd: mc13xxx adc fixes and enhancements
In-Reply-To: <20120130080714.GK6305@pengutronix.de>
References: <1327876408-22528-1-git-send-email-marc@cpdesign.com.au>
 <20120130080714.GK6305@pengutronix.de>
Message-ID: <4F34CE38.5040502@protonic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2012 09:07 AM, Uwe Kleine-K?nig wrote:
> Hello,
>
> On Mon, Jan 30, 2012 at 09:33:22AM +1100, Marc Reilly wrote:
>> This series provides some small fixes to the mc13xxx adc conversion funtion to
>> make it more robust. Readout of single channel conversions is fixed so that the
>> read out order corresponds to the sampling order (Critical for dedicated
>> battery reading).
>>
>> A new conversion function is introduced which allows the caller to enable the
>> dedicated readings and other adc functionality by providing a mask/ value pair
>> for the adc0,1 registers.
>>
>> These patches apply onto my 'add I2C support' series [1].
>> (I think only the first patch is required)
> I wonder if Robin van der Gracht (added to Cc:) can say something to
> this series as he seems to have used the adc recently.
>
> @Robin: tell me if I should bounce you the series.
>
> Best regards
> Uwe
>
Uwe,
I would like to recieve the new series,

Regards,

-- 
Robin van der Gracht
Protonic Holland.
tel.: +31 (0) 229 212928
fax.: +31 (0) 229 210930
Factorij 36 / 1689 AL Zwaag

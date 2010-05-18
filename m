From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 19 May 2010 09:23:07 +1200
Subject: [RFC PATCH 2/3] ep93xx i2s core support
In-Reply-To: <AANLkTikPnVJqHhd4-VYtpLC19zMkrM9LoU3TU1y67zQH@mail.gmail.com>
References: <4BF21B67.8090404@bluewatersys.com> <4BF21D74.206@bluewatersys.com>
	<AANLkTikPnVJqHhd4-VYtpLC19zMkrM9LoU3TU1y67zQH@mail.gmail.com>
Message-ID: <4BF3053B.3050402@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chase Douglas wrote:
> On Tue, May 18, 2010 at 12:54 AM, Ryan Mallon <ryan@bluewatersys.com> wrote:
>> Add ep93xx core support for i2s audio
>>
>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
>> ---
>>
>> +
>> +       ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_I2SONAC97 |
>> +                                EP93XX_SYSCON_DEVCFG_I2SONAC97);
> 
> I think one of the above should be *_I2SONSSP?

Yup, stupid cut and paste error :-). Fixed.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934

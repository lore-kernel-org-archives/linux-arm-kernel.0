From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Sat, 06 Jun 2015 02:52:12 -0300
Subject: [PATCH v3 0/2] reset driver for NXP LPC18xx family
In-Reply-To: <1431003665.3014.36.camel@pengutronix.de>
References: <1430863827-21898-1-git-send-email-manabian@gmail.com>
 <1431003665.3014.36.camel@pengutronix.de>
Message-ID: <55728A8C.10207@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2015 10:01 AM, Philipp Zabel wrote:
> Am Mittwoch, den 06.05.2015, 00:10 +0200 schrieb Joachim Eastwood:
>> This patch set adds a reset driver for NXP LPC18xx/43xx devices.
>>
>> Changes in v3:
>> * add patch descriptions
>> * change parameter name in to_rgu_data macro to avoid a potential
>>   issue if code is changed.
>>
>> Changes in v2:
>> * clean up header includes
>> * prefix M0 reset defines with LPC43XX
>> * fix comment about M0 reset lines
>> * reorganize reset call chains
>> * add reset number table to dt doc
>>
>> There are no dependencies in this patch set. The DTS changes will
>> be sent separately to arm-soc once this patch set goes upstream.
>>
>> Base support for the NXP LPC18xx family can be found here:
>> http://marc.info/?l=linux-arm-kernel&m=143016894704253&w=2
>>
>> Joachim Eastwood (2):
>>   reset: add driver for lpc18xx rgu
>>   doc: dt: add documentation for lpc1850-rgu reset driver
> 
> Applied both, thanks.
> 

Philipp,

Any chance we can have the reset controllers' tree to linux-next?

Thanks!
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar

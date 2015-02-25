From: ezequiel.garcia@imgtec.com (Ezequiel Garcia)
Date: Wed, 25 Feb 2015 09:30:06 -0300
Subject: [PATCH 0/7] New eFuse subsystem
In-Reply-To: <20150225120234.GB5062@lukather>
References: <1424864719-3390-1-git-send-email-ezequiel.garcia@imgtec.com>
 <20150225120234.GB5062@lukather>
Message-ID: <54EDC04E.1050107@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/25/2015 09:02 AM, Maxime Ripard wrote:
> Hi Ezequiel,
> 
> On Wed, Feb 25, 2015 at 08:45:12AM -0300, Ezequiel Garcia wrote:
>> This patchset introduces a new driver subsystem, meant to support eFuse
>> (alias OTP, one-time-programmable) devices.
>>
>> The motivation behind this work is to have a common place for drivers
>> that are currently more or less scattered: the tegra efuses are in
>> drivers/soc/ and the sunxi efuses in drivers/misc/eeprom.
>>
>> For now, there's no proposal for a generic efuse API. Instead, we simply
>> group the drivers together.
>>
>> This patchset is the result of the initial submission for IMG Pistachio
>> eFuse support [1]. Our first proposal was to follow the Tegra efuse, and
>> put the Pistachio efuse in drivers/soc. After some discussion we finally
>> agreed [2] to first create an efuse directoy, and then put all efuse drivers
>> in it.
>>
>> As always, all comments are welcome!
>>
>> [1] http://www.spinics.net/lists/devicetree/msg59246.html
>> [2] http://www.spinics.net/lists/arm-kernel/msg389325.html
> 
> Have you looked at the EEPROM framework currently in discussions? The
> two seems to be covering pretty much the same use cases.
> 

Nope, I was obviously unaware of that. Guess we'll wait until the
discussion is settled and use that framework.

Thanks!
-- 
Ezequiel

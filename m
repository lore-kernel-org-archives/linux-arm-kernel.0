From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Thu, 14 Aug 2014 16:01:14 -0500
Subject: [PATCH 2/3] ARM: dts: socfpga: Add SD card detect
In-Reply-To: <20140814205941.GA26857@amd.pavel.ucw.cz>
References: <1408031491-15609-1-git-send-email-dinguyen@opensource.altera.com>
 <1408031491-15609-3-git-send-email-dinguyen@opensource.altera.com>
 <20140814185158.GD11558@amd.pavel.ucw.cz>
 <53ED22D0.3060404@opensource.altera.com>
 <20140814205941.GA26857@amd.pavel.ucw.cz>
Message-ID: <53ED239A.8090905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/14/14, 3:59 PM, Pavel Machek wrote:
> On Thu 2014-08-14 15:57:52, Dinh Nguyen wrote:
>>
>>
>> On 8/14/14, 1:51 PM, Pavel Machek wrote:
>>> On Thu 2014-08-14 10:51:30, dinguyen at opensource.altera.com wrote:
>>>> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>>>>
>>>> Revision D of the SOCFGPA devkit has a GPIO line used for SD/MMC
>>>> card detect.
>>>
>>> Are there previous revisions outside Altera?
>>>
>>
>> Not with SD card detect.
> 
> So this patch will break those revision C (and below) boards, by
> adding gpio for card detect that does not exists there, no?
> 

No, the card detect line is muxed with DAT3, so it'll work fine on
previous boards that does have card detect.
> Confused,

Tested on all board revisions.

Dinh

From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Thu, 13 Mar 2014 09:24:15 +0100
Subject: [PATCH 0/3] ARM: dts: overo: Add graphics output
In-Reply-To: <5320093D.2010600@ti.com>
References: <1394541257-25605-1-git-send-email-florian.vaussard@epfl.ch>
 <5320093D.2010600@ti.com>
Message-ID: <53216B2F.5000409@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/12/2014 08:14 AM, Tomi Valkeinen wrote:
> On 11/03/14 14:34, Florian Vaussard wrote:
>> Hi,
>>
>> This series enables the DVI / LCD graphics present on some of
>> the Overo expansion boards.
>>
>> DVI output:
>> - Tobi
>> - Summit
>>
>> LCD (3.5''):
>> - Alto35
>>
>> LCD (4.3''):
>> - Chestnut43
>> - Palo43
>> - Gallop43
>>
>> I tested on Tobi, Alto35 and Gallop43 using both OMAP35xx and OMAP36xx
>> Overo boards.
>>
>> This series depends on Tomi's DSS patches [1] that are not yet merged.
>> It also depends on previous Overo series [2] and [3] that are under
>> review. A complete testing tree is available [4].
> 
> Looks good to me. Unfortunately the video bindings are still being
> discussed (mainly the ports/endpoints), so there might be changes needed
> when some kind of conclusion is reached.
> 

Yes, I saw. This is why I posted this separately from the other patches.
I will update if necessary, let's wait.

Regards,
Florian

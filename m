From: o.schinagl@ultimaker.com (Olliver Schinagl)
Date: Wed, 09 Sep 2015 16:26:10 +0200
Subject: [PATCH 0/5] Add eeprom to the Olimex series of boards
In-Reply-To: <20150909140559.GD9885@lukather>
References: <1441790715-11957-1-git-send-email-o.schinagl@ultimaker.com>
 <20150909140559.GD9885@lukather>
Message-ID: <55F04182.2000707@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09-09-15 16:05, Maxime Ripard wrote:
> On Wed, Sep 09, 2015 at 11:25:10AM +0200, Olliver Schinagl wrote:
>> Some of the olimex series of boards feature a permanently connected eeprom on
>> i2c-1. This patch series adds them on all the boards that have them according
>> to the spec-sheets.
>>
>> I explicitly added my personal --Tested-by to boards I actually tested.
> Testing your changes is the strict minimum before testing your
> patches. Just like running checkpatch on them, which you clearly
> failed to do, otherwise you would have seen that this is not the right
> syntax. Drop the tested-by, fix your SoB.
Actually, I did run check-patch and it complained about the format, but 
it was the same as when outputted with a git -s. I obviously missed 
something there! So I double check that. I will resubmit without a 
tested-by for the boards I did test it on.
>
>> There are two boards, that according to the sheets have them as well
>> and physically inspecting the boards shows them clearly, I did not
>> actually test them on those the boards that are missing the
>> --Tested-by.
> Then don't send those patches.
I put them out there so someone could pick up on that with the least 
amount of effort. I will drop them
>
> Maxime
>

-- 
Met vriendelijke groeten, Kind regards, ??????

Olliver Schinagl
Research & Development
Ultimaker B.V.

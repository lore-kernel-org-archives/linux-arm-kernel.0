From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Fri, 24 Feb 2017 07:10:53 +0100
Subject: [PATCH] ARM: dts: BCM5301X: Add basic DT for Linksys EA9500
In-Reply-To: <CACna6ryFQHGN6xYiLcp9-v7f+55-4hoq+6kXCjiT6LJOS70sQQ@mail.gmail.com>
References: <20170223104025.5755-1-zajec5@gmail.com>
 <bd36df47-cefe-5736-e02c-621a21ae1b7a@openwrt.org>
 <CACna6rzN-OQv4UJoRso_Kyf1rCEtuU5Lu9LDjvTTt011UgrA=Q@mail.gmail.com>
 <5c57772b-71fd-d9e2-efe6-1175cf048e0b@openwrt.org>
 <CACna6ryFQHGN6xYiLcp9-v7f+55-4hoq+6kXCjiT6LJOS70sQQ@mail.gmail.com>
Message-ID: <CACna6rzn3YDBqwReEikqjfhpMk-uQj0cuNaay2HyK0kLc_xuJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 February 2017 at 07:02, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
> On 23 February 2017 at 13:44, Imre Kaloz <kaloz@openwrt.org> wrote:
>> On 2017-02-23 13:29, Rafa? Mi?ecki wrote:
>>>
>>> On 23 February 2017 at 13:27, Imre Kaloz <kaloz@openwrt.org> wrote:
>>>>
>>>> As discussed for other platforms as well, please use the board's name as
>>>> the
>>>> same board can end up being sold under multiple model numbers.
>>>>
>>>> So please rename the file to bcm47094-linksys-panamera.dts
>>>
>>> Huh? Where did you get panamera name from?!
>>
>> Your manners shine on these dark days of winter. For about a decade now,
>> http://192.168.1.1/sysinfo.cgi will show you quite a bit of information if
>> you are too lazy to look into the GPL tarball or at the original bootlogs.
>
> Today I decided to do my homework & check GPL sources of EA9500 fw.
>
> (...)
>
> Will you be so generous to tell us how did you get EA9500 board name
> by just looking at GPL sources?

I also tried find with -name "*panamera*". One way of guessing board
name seems to be checking names of patches in ./src/linux/patches/.
Any other, more reliable method?

-- 
Rafa?

From: gerg@snapgear.com (Greg Ungerer)
Date: Sat, 8 Sep 2012 00:15:11 +1000
Subject: [PATCH] ARM: ixp4xx: move fixed mapping of internal devices into
 vmalloc region
In-Reply-To: <201209071323.56574.arnd@arndb.de>
References: <1346996400-5824-1-git-send-email-gerg@snapgear.com>
 <201209071223.30275.arnd@arndb.de> <m3oblic6x0.fsf@intrepid.localdomain>
 <201209071323.56574.arnd@arndb.de>
Message-ID: <504A016F.6020304@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/2012 11:23 PM, Arnd Bergmann wrote:
> On Friday 07 September 2012, Krzysztof Halasa wrote:
>>>>    BUG: mapping for 0xc8000000 at 0xffbeb000 out of vmalloc space
>>>>    BUG: mapping for 0xc4000000 at 0xffbfe000 out of vmalloc space
>>>>    BUG: mapping for 0xc0000000 at 0xffbff000 out of vmalloc space
>>
>>> Imre, Krzysztof: do you prefer to take this patch into a branch of yours
>>> and send a pull request, or should we just apply it directly into arm-soc.
>>> In the former case, can you provide an Ack?
>>
>> My intention is to push the following instead:
>>
>> http://git.kernel.org/?p=linux/kernel/git/chris/linux.git;a=commitdiff;h=f62736b567ff532fb772afea76fccdbcd92ab473;hp=23e3b6cf1c37ef0615d90681d3705a8821305b5f
>>
>
> Ok, fine with me. I noticed however that this is missing
> a changelog. Maybe you can take the text that Greg sent.
>
> I also wonder if this patch needs to be applied to earlier
> versions as well. Is linux-3.6 still working?

It only seemed to be a warning. The boards I tested on worked with
no problems that I could see. That was on a linux-3.5 kernel.

Regards
Greg


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com

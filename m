From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 17 Jun 2013 11:27:38 +0200
Subject: [GIT PULL] at91: soc updates for 3.11 #1
In-Reply-To: <EABCC4A72A203F4BA2E04297CF0282C427D1E1F8@hnombx01.corp.atmel.com>
References: <1371246138-22207-1-git-send-email-nicolas.ferre@atmel.com>,
 <20130615023702.GA8635@quad.lixom.net>
 <EABCC4A72A203F4BA2E04297CF0282C427D1E1F8@hnombx01.corp.atmel.com>
Message-ID: <04994E22-F6D8-4786-9E2D-94D811C8020B@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jun 17, 2013, at 11:20 AM, "Ferre, Nicolas" <Nicolas.FERRE@atmel.com> wrote:

> From: Olof Johansson [olof at lixom.net]
>> Hi,
>> 
>> On Fri, Jun 14, 2013 at 11:42:18PM +0200, Nicolas Ferre wrote:
>>> Arnd, Olof,
>>> 
>>> A little AT91 pull-request for patches that are more targeted to SoC/boards
>>> modifications. It is prepared on top of the arm-soc/at91/cleanup branch.
>>> 
>>> Thanks, best regards,
>>> 
>>> The following changes since commit b3f442b0eedbc20b5ce3f4a96530588d14901199:
>>> 
>>>  ARM: at91: udpate defconfigs (2013-05-17 15:05:08 +0200)
>>> 
>>> are available in the git repository at:
>>> 
>>>  git://github.com/at91linux/linux-at91.git tags/at91-soc
>>> 
>>> for you to fetch changes up to 7e75545ea7fb972c3da759f92c3d0be84d1cee72:
>>> 
>>>  ARM: at91: drop rm9200dk board support (2013-06-14 23:34:11 +0200)
>>> 
>>> ----------------------------------------------------------------
>>> Two non critical fixes that can go in 3.11.
>>> An old board removed.
>>> 
>>> ----------------------------------------------------------------
>>> Alexandre Belloni (1):
>>>      ARM: at91: Fix link breakage when !CONFIG_PHYLIB
>> 
>> Fix
>> 
>>> Jean-Christophe PLAGNIOL-VILLARD (1):
>>>      ARM: at91: drop rm9200dk board support
>> 
>> Cleanup
>> 
>>> Wenyou Yang (1):
>>>      ARM: at91: Change the internal SRAM memory type MT_MEMORY_NONCACHED
>> 
>> Fix
>> 
>> ...assuming, of course, that none of the fixes are for errors introduced in
>> some branch we already pulled, since then they should go on top of that branch.
> 
> I do agree with you but:
> 1/ the fixes are non-critical ones, so I do not see the need for another branch
> 2/ I didn't feel like touching the "cleanup" branch because we want to base all our 3.11 material on top of it, without adding new patches on top.
I do agree with Nico on this as the cleanup this time was done early to avoid nightmare conflict so I prefer we do not touch it

Best Regards,
J.
> 
> But, tell me if you think that it is too cautious...
> 
> Bye,
> -- 
> Nicolas Ferre

From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 22 May 2012 13:03:33 +0100
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <20120518192011.GD24238@titan.lakedaemon.net>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201205161946.34179.arnd@arndb.de>
 <alpine.LFD.2.02.1205161552490.1640@xanadu.home>
 <201205162034.49392.arnd@arndb.de>
 <20120518192011.GD24238@titan.lakedaemon.net>
Message-ID: <4FBB8095.4070402@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/05/12 20:20, Jason Cooper wrote:
> On Wed, May 16, 2012 at 08:34:49PM +0000, Arnd Bergmann wrote:
>> On Wednesday 16 May 2012, Nicolas Pitre wrote:
>>> In this case, we have wildly different names referring to the same chip
>>> family, and "orion" is far from hinting that it also constitute the
>>> support for Kirkwood, Dove or (some not all) Armadas, unless you are
>>> familiar with some legacy Marvell products.  This is why in this case I
>>> think that a directory name change might be appropriate, especially if
>>> we're going to cause churn by moving things around already.
>>>
>>> I agree that mrvl_ebu_* is not pretty.  This could be mv_ebu_* or
>>> mvebu_*.  Unless someone has another logical identifier to suggest which
>>> would capture all that family of SOCs that came out of EBU in Marvell of
>>> course.
>>>
>>> Since this is code not marketing, we don't have to have something flashy
>>> either, as long as it doesn't create more confusion than "orion" does.
>>> The various Kconfig help texts are good places to put all the marketing
>>> names du jour.
>>
>> mvebu sounds reasonable to me, it's definitely unique and it's almost a
>> word ;-)
>
> mvebuntu? *ducks*

you, sir, are clearly quackers.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

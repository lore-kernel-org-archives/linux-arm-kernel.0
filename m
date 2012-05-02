From: rmallon@gmail.com (Ryan Mallon)
Date: Wed, 02 May 2012 16:30:39 +1000
Subject: Request for inclusion of ep93xx tree in linux-next
In-Reply-To: <201205010836.28365.arnd@arndb.de>
References: <4F9F16A9.9090108@gmail.com> <201205010836.28365.arnd@arndb.de>
Message-ID: <4FA0D48F.2090800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/12 18:36, Arnd Bergmann wrote:

> On Monday 30 April 2012, Ryan Mallon wrote:
>> Hi Stephen,
>>
>> Can you please add the following branches:
>>
>>   ep93xx-cleanup
>>   ep93xx-fixes
>>
>> from the ep93xx git tree:
>>
>>   git://github.com/RyanMallon/linux-ep93xx.git
>>
>> To linux-next. Both branches are stable and based on v3.4-rc2. Testing
>> for the tree is covered by the arm ep93xx_defconfig.
>>
> 
> Hi Ryan,
> 
> just for your convenience, it helps if you have only one branch that
> you get included into linux-next and that combines various branches
> which you intend to send to arm-soc. That frees you from the need to
> notify Stephen every time you want to have another branch included.


Thanks for the tip. I leave the branches as is for the moment. If I end
up adding any additional branches to my tree, then I will look at
creating an ep93xx-for-next branch then. In this case, should the
for-next branch just be a regular merge of all the other branches I
have? How do I make it verifiable that everything from the other
branches has been being tested in the for-next branch?

Thanks,
~Ryan

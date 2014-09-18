From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 18 Sep 2014 21:33:01 +0200
Subject: [PATCH 18/19] ARM: SAMSUNG: Remove remaining legacy code
In-Reply-To: <1411068565.2017.83.camel@x220>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>	
 <1404496099-26708-19-git-send-email-t.figa@samsung.com>	
 <1405505756.4408.24.camel@x220> <53C676DB.6070002@samsung.com>	
 <1409825817.5546.99.camel@x220> <1411068565.2017.83.camel@x220>
Message-ID: <541B336D.3030506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.09.2014 21:29, Paul Bolle wrote:
> On Thu, 2014-09-04 at 12:16 +0200, Paul Bolle wrote:
>> On Wed, 2014-07-16 at 14:58 +0200, Tomasz Figa wrote:
>>> I had two patches fixing those, but apparently this was lost in action.
>>> The correct solution is s/PLAT_S5P/ARCH_S5PV210/. I will include this in
>>> a follow-up series if nobody objects.
>>
>> No one objected, as far as I know.
>>
>> Exactly the same references are still to be found in v3.17-rc3 and
>> next-20140903. Perhaps someone actually familiar with this matter (ie,
>> not me) could submit one or more patches that implement Tomasz'
>> proposal.
> 
> We're now at v3.17-rc5 and next-20140918 and nothing has changed. I
> raised this issue the day it hit linux-next. After two months it's still
> not fixed. Could anyone familiar with ARCH_S5PV210 please jump in?

Basically, it turned out that no respin was necessary and I didn't post
those two patches. Now, I don't work for Samsung anymore, but let me see
if I can find them in my private tree and then some time to send them.

Best regards,
Tomasz

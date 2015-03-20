From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 20 Mar 2015 17:29:28 +0000
Subject: ATSAMA5D big endian work
In-Reply-To: <20150320171940.GE20930@piout.net>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
 <20150318183040.GT4560@piout.net> <550A9833.2080408@codethink.co.uk>
 <20150319133050.GD4750@piout.net> <550C51BF.6030501@codethink.co.uk>
 <20150320171940.GE20930@piout.net>
Message-ID: <550C58F8.8080302@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/15 17:19, Alexandre Belloni wrote:
> Hi,
> 
> On 20/03/2015 at 16:58:39 +0000, Ben Dooks wrote :
>>> You can use this branch until Nicolas merges my patches:
>>>
>>> https://github.com/alexandrebelloni/linux/tree/at91_4.1_04_cleanup2
>>>
>>> The remaining __raw_writel and __raw_readl are in pm.h
>>
>> Ok, should I submit my next series for inclusion in to your tree?
>>
> 
> I've sent all my series and Nicolas is supposed to take them soon so I
> think the best would be to wait a bit. IF you want, I'll ping you when
> everything is in.

Ok, I'll try and re-base on and test with your series in prep.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

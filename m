From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 03 Dec 2015 14:43:05 +0100
Subject: [PATCH v4 net 0/6] Marvell Armada XP/370/38X Neta fixes
In-Reply-To: <20151202.153152.345490122870853342.davem@davemloft.net> (David
 Miller's message of "Wed, 02 Dec 2015 15:31:52 -0500 (EST)")
References: <1448886466-31538-1-git-send-email-mw@semihalf.com>
 <20151201.220337.2287051759324173025.davem@davemloft.net>
 <87wpsx2rll.fsf@free-electrons.com>
 <20151202.153152.345490122870853342.davem@davemloft.net>
Message-ID: <874mfz1wd2.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,
 
 On mer., d?c. 02 2015, David Miller <davem@davemloft.net> wrote:

> From: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Date: Wed, 02 Dec 2015 09:16:06 +0100
>
>> Hi David,
>>  
>>  On mer., d?c. 02 2015, David Miller <davem@davemloft.net> wrote:
>> 
>>> From: Marcin Wojtas <mw@semihalf.com>
>>> Date: Mon, 30 Nov 2015 13:27:40 +0100
>>>
>>>> I'm sending v4 with corrected commit log of the last patch, in order
>>>> to avoid possible conflicts between the branches as suggested by
>>>> Gregory Clement.
>>>
>>> Series applied, thanks.
>> 
>> Could you confirm that you don't apply the last patch?
>
> If I say it's applied then it's applied, and if you don't like it then
> you'll have to submit a revert patch against my tree or similar.
>
> You know you could just check my tree instead of asking.

Well I was very surprised that you applied a patch in a subsystem that
you do not maintain. As written on the lines just below yours, the
purpose of this v4 was to make clear that the last patch is not for the
net subsystem but for the arm/mvebu one.

As this series will be part of the next rc, then I hope we won't have
conflicts during next merge.

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

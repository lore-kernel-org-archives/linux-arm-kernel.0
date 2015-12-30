From: davem@davemloft.net (David Miller)
Date: Tue, 29 Dec 2015 20:48:47 -0500 (EST)
Subject: [RESEND PATCH v1 0/4] Add support emac for the RK3036 SoC platform
In-Reply-To: <3925713.yDzK1dvrIv@diego>
References: <1451287341-16453-1-git-send-email-zhengxing@rock-chips.com>
 <20151229.155314.1522114236952280828.davem@davemloft.net>
 <3925713.yDzK1dvrIv@diego>
Message-ID: <20151229.204847.578920480799799256.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko St?bner <heiko@sntech.de>
Date: Tue, 29 Dec 2015 23:27:55 +0100

> Hi Dave,
> 
> Am Dienstag, 29. Dezember 2015, 15:53:14 schrieb David Miller:
>> You have to submit this series properly, the same problem happend twice
>> now.
>> 
>> When you submit a series you should:
>> 
>> 1) Make it clear which tree you expect these changes to be applied
>>    to.  Here it is completely ambiguous, do you want it to go into
>>    my networking tree or some other subsystem tree?
>> 
>> 2) You MUST keep all parties informed about all patches for a series
>>    like this.  That means you cannot drop netdev from patch #4 as
>>    you did both times.  Doing this aggravates the situation for
>>    #1 even more, because if a patch is not CC:'d to netdev it does
>>    not enter patchwork.  And if it doesn't go into patchwork, I'm
>>    not looking at it.
> 
> I guess that is some unfortunate result of git send-email combined with 
> get_maintainer.pl . In general I also prefer to see the whole series, but have 
> gotten such partial series from other maintainers as well in the past, so it 
> seems to be depending on preferences somewhat.
> 
> For the series at hand, the 4th patch is the devicetree addition, which the 
> expected way is me picking it up, after you are comfortable with the code-
> related changes.

Why would it not be appropriate for a DT file change to go into my tree
if it corresponds to functionality created by the rest of the patches
in the series?

It looks better to put it all together as a unit, via one series, with
a merge commit containing your "[PATCH 0/N]" description in the commit
message.

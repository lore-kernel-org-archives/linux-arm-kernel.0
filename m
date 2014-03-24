From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 24 Mar 2014 15:03:19 +0100
Subject: [PATCH] i2c: mv64xxx: Fix compilation breakage
In-Reply-To: <20140324133349.GA2631@katana>
References: <1394204370-22979-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140307160836.GM21483@n2100.arm.linux.org.uk>
 <20140310105808.GE2815@lukather>
 <20140310112929.GY21483@n2100.arm.linux.org.uk>
 <CAP=VYLqCmG6fRmPPABoW4xg_tFgGh2pji=f5ML=cBgCu4zZocg@mail.gmail.com>
 <20140321191739.GT27873@lukather> <20140324133349.GA2631@katana>
Message-ID: <53303B27.2040201@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

On 24/03/2014 14:33, Wolfram Sang wrote:
> 
>>> Looping linux-next into the CC since this is the cause of the failure
>>> in orion5x_defconfig there, and no point in anyone else re-doing the
>>> same bisect.
>>
>> I sent a fix for this that hasn't been picked up yet:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/239069.html
>>
>> IIRC, Wolfram's away until Monday, so I guess it will be merged some
>> time next week.
> 
> I'd love to apply the fix but the reset framework update is not in
> linux-next yet.
> 

I saw the there was a pull request resent last week. Is there any
reason to not have pulled it, yet?
http://www.spinics.net/lists/arm-kernel/msg316518.html

I would really like that it was sorted out, because all the build using
the mvebu related defconfig fails since two weeks because of it now.

I am ready to help if you need it.

Thanks!


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

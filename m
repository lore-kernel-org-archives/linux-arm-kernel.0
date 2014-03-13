From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 13 Mar 2014 09:51:29 +0000
Subject: [PATCH 0/2] ARM: add initial support for the Marvell BG2-Q DMP
In-Reply-To: <20140312113523.GL13905@piout.net>
References: <1394622364-6848-1-git-send-email-antoine.tenart@free-electrons.com>
 <20140312113523.GL13905@piout.net>
Message-ID: <53217FA1.4020903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2014 11:35 AM, Alexandre Belloni wrote:
> On 12/03/2014 at 12:06:02 +0100, Antoine T?nart wrote :
>> This serie adds the initial support for the Marvell BG2-Q DMP (part of the
>> Berlin family). SoC has nodes for cpu, l2 cache controller, interrupt
>> controllers, local timer, apb timers and uarts for now.
>>
>> Homepage: http://www.marvell.com/digital-entertainment/armada-1500-pro/
>>
>
> I would move that description to the commit logs. Else one would have to
> lookup the mailing list archive to read it.

Antoine,

thanks for posting this. I also prefer each patch to have a commit log
no matter how obvious the contents may be. Please have a simple commit
log for each of the single patches.

You can leave out the link to marvell.com in the commit log as you
update Marvell SoC documentation.

TBH, I haven't set up any mach-berlin branches, yet. Also it is very
late in the cycle. I'll setup proper branches and also a -next branch
for next release, maybe we can take your DT patches directly through
arm-soc this time. Otherwise, we'll have to postpone them for v3.16.

I have some comments on the single patches and will reply there.

Sebastian

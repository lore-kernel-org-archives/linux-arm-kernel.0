From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 05 Sep 2011 21:25:46 +0200
Subject: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53
	platforms
In-Reply-To: <CAODfWeEueF45_yvPV5Zxbva6K2gEfKZbY2qoqySYFPZWnSgLsg@mail.gmail.com>
	(Hector Oron's message of "Wed, 31 Aug 2011 13:57:06 +0100")
References: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
	<CAODfWeEm8bkySXxb1qopbH1VMu-V+33k5x+0+qjABzesT0amOA@mail.gmail.com>
	<CAJNCFV+XFGEba1J2dXDa4YVwqduAPV5y=5JYEXAZ0uv+S60vvw@mail.gmail.com>
	<CAODfWeEueF45_yvPV5Zxbva6K2gEfKZbY2qoqySYFPZWnSgLsg@mail.gmail.com>
Message-ID: <877h5m7pvp.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hector Oron <hector.oron@gmail.com> writes:

> Hello,

Hi,

>
> 2011/8/31 Richard Zhu <richard.zhu@linaro.org>:
>> Hi Hector:
>> Thanks for your help to tests these patches.
>
> Note I rebased this patches against 'imx-features' branch on Sascha's tree.
> I am noticing some obscure (to me) messages from kernel:

Currently testing with probably same checkout of imx-features branch
with a sata 3.5" drive. Running badblocks in non destructive write mode
and so far, so good (it's slow but it may comes from my drive).

Did you test if there was a bad cable or faulty drive PSU ?

Arnaud

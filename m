From: r.sricharan@ti.com (R, Sricharan)
Date: Mon, 14 May 2012 10:20:53 +0530
Subject: [PATCH 00/13] ARM: OMAP5: Add minimal OMAP5 SOC support
In-Reply-To: <20120511201113.GA21851@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <e02393fc87c4e06ce1d783a03747aff7@mail.gmail.com>
 <20120511201113.GA21851@atomide.com>
Message-ID: <CAJ7qFSdLXq9dxFT65X1uSqEbqnnHXMewb+h=4mD-M1VNt1STcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,
  Thanks for you suggestions

>> ?OMAP5 V2 series is ready with all comments addressed, but I have
>> ?below dependencies to be merged to apply my series against your
>> ?cleanup-soc branch
>
> OK
>
>> ?1) git://git.pwsan.com/linux-2.6 hwmod_soc_conditional_cleanup_3.5
>
> This one is not merged in yet and it seems that we're out of time
> for v3.5 unless it drags on and we have -rc8 after -rc7.
>
 OK
>> ?2) git://git.pwsan.com/linux-2.6 hwmod_data_cleanup_3.5
>> ?3) https://github.com/hvaibhav/am335x-linux ? 32ksync-timer-cleanup
>
> These two are merged in arm-soc now.
>
 OK
>> ?4) http://www.spinics.net/lists/arm-kernel/msg174461.html
>
> I think this series still has some pending comments?
>
 Yes, right. In fact except for the last patch,
 others should not be needed when rebased against
 paul's PRCM cleanups which is yet to be posted and
 [1] which is already acked now.

  1) http://www.spinics.net/lists/linux-omap/msg70192.html

>> ?Can you please let me know how you want me to prepare the series
>> ?with these dependencies.
>
> Until these dependencies get cleared out, it seems that the best
> branch to base your patches is omap-cleanup-timer-for-v3.5 tag
> and just carry the pending patches for a little bit longer.
>
 Ok, will rebase against it then and then prepare the series with a couple
of temporary patches that can be dropped when the above mentioned dependencies
are sorted out.


Thanks,
 Sricharan

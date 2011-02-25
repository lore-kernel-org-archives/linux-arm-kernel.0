From: dima@android.com (Dima Zavin)
Date: Thu, 24 Feb 2011 18:39:48 -0800
Subject: [PATCH v2 2/2] msm: add single-wire serial bus interface (SSBI)
	driver
In-Reply-To: <1298601346.17118.29.camel@m0nster>
References: <1298585954-22422-1-git-send-email-kheitke@codeaurora.org>
	<1298585954-22422-3-git-send-email-kheitke@codeaurora.org>
	<1298600621.17118.27.camel@m0nster>
	<8yad3mgdeut.fsf@huya.qualcomm.com>
	<1298601346.17118.29.camel@m0nster>
Message-ID: <AANLkTikD1Ued=rit1QbMWwe3NGFz2iQ-KO7B=-N6Ok-2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On that note, should we have a "drivers/arm/msm" instead of just
"drivers/msm"? Other non-msm arm sub-arches probably have the same
problem and polluting drivers/ top-level for every arm-subarch maybe
undesirable.

--Dima


On Thu, Feb 24, 2011 at 6:35 PM, Daniel Walker <dwalker@fifo99.com> wrote:
> On Thu, 2011-02-24 at 18:31 -0800, David Brown wrote:
>> On Thu, Feb 24 2011, Daniel Walker wrote:
>>
>> > You have some submission problems. one is that the subject should be
>> > "drivers: msm: ..." , this patch also shouldn't go to David.
>>
>> Subject needs to be fixed. ?Patch to add drivers/msm to the maintainers
>> file has been Acked, so this should be sent to the MSM maintainers.
>
> It was only acked by Nico, he's just the one who suggested it. I think
> Greg needs to be involved at some level ..
>
> Daniel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at ?http://www.tux.org/lkml/
>

From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 11 Jan 2014 03:19:54 +0300
Subject: [PATCH v4 0/2] ohci and ehci-platform clks, phy and dt support
In-Reply-To: <878uun1llt.fsf@nemi.mork.no>
References: <1389393980-21183-1-git-send-email-hdegoede@redhat.com>	<52D0875B.9040102@cogentembedded.com>
 <52D0799B.3030401@redhat.com> <878uun1llt.fsf@nemi.mork.no>
Message-ID: <52D08E2A.4080703@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/11/2014 02:08 AM, Bj?rn Mork wrote:

>>>> Here is v4 of my ohci and ehci-platform clks, phy and dt support patch-set,
>>>> this version should be 100% ready for merging upstream.

>>>      I see you've decided to completely ignore my opinion. NAK, FWIW.

>> I'm sorry but the whole prefix thing has become a thing of -ETOOMUCHBIKESHEDDING,
>> everyone except you seems to be fine with mmio and and one point in time we
>> need to make a decision and move forward.

> FWIW I agree with your decision - not that I think that matters to
> anyone :-)

    It matters at least to me, potential user of this stuff. It's a pity that 
I haven't done this myself (in fact, I had other idea than this: writing a 
specific driver for my platform). As they say "if you want it done right, do 
it yourself".

> But it would have been nice if you summarized the discussion in the
> cover letter, including the reason behind your decision.  Just so that

    The reason seems quite clear: Hans wants it to be merged really fast.

> Sergei and other reviewers would see that you didn't actually ignore any
> opinion.  You just didn't agree, and you had your reasons to do so.

    Hans hasn't replied to my last mail, so I felt ignored, yes.

> Bj?rn

WBR, Sergei

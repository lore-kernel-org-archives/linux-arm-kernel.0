From: myungjoo.ham@gmail.com (MyungJoo Ham)
Date: Mon, 26 Dec 2011 13:16:41 +0900
Subject: Pull Requeset: Exynos4 Register Address Update for Devfreq
 Drivers.
In-Reply-To: <088b01ccc1df$994d0090$cbe701b0$%kim@samsung.com>
References: <CAJ0PZbQ1=+BTs0Emi78kfOWD5d90+ND5Jc_SJ9T4BcGMXyny9A@mail.gmail.com>
 <088b01ccc1df$994d0090$cbe701b0$%kim@samsung.com>
Message-ID: <CAJ0PZbSozVrr70c4s6-F-_dNETo7Of37RxGwQnrjt2mva9B_sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 24, 2011 at 10:58 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> As I commented, looks ok to me and will apply patches not pull and since I
> didn't get your answer to ask 'topic branch is required for this', I didn't
> yet.
>
> As a note, if there is no reason to create based on not -rc, just use -rc.
>
> Merry Christmas.
> Thanks.
>


Hello,

Having a topic branch for devfreq is fine and I don't care whether
there is one or not as long as the required registers are supported.

Because the registers added in the patches do not seem to be devfreq
specific, I don't think we should have another branch for this. Thus,
having the patches in your Exynos' branch is also fine.

I'll let future pull-requested branches be rebased on rcX anyway. Thanks.


Cheers! Happy new year!
- MyungJoo

-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics

From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 22 Jan 2014 09:59:31 -0800
Subject: [PATCH] clk: export __clk_get_hw for re-use in others
In-Reply-To: <CAEjAshrxXLJ-zFsTO9TnewYBBEPzFR1cixbLnD6U-U1EKdByxg@mail.gmail.com>
References: <1390110907-29918-1-git-send-email-sj38.park@gmail.com>
 <20140119173712.GA26481@kroah.com>
 <CAPtuhTikj38yKy-=uF7O+VFG_N4AWee23f9woemM318fM3V4VQ@mail.gmail.com>
 <CAEjAshoh5ucPJA6pG1sx+7HGCYjHzCKtbzmH+GYJwpefDYLwJg@mail.gmail.com>
 <CAEjAshozB4S0ZGqEn41ROfZwGTV+_GZRRTZ8cssi0VdH8Uhr_w@mail.gmail.com>
 <20140122045937.GB23869@kroah.com>
 <CAEjAshrxXLJ-zFsTO9TnewYBBEPzFR1cixbLnD6U-U1EKdByxg@mail.gmail.com>
Message-ID: <52E00703.5080001@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/14 21:23, SeongJae Park wrote:
> On Wed, Jan 22, 2014 at 1:59 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Wed, Jan 22, 2014 at 12:05:57PM +0900, SeongJae Park wrote:
>>> Dear Greg, Mike,
>>>
>>> May I ask your answer or other opinion, please?
>> It's the middle of the merge window, it's not time for new development,
>> or much time for free-time for me, sorry.  Feel free to fix it the best
>> way you know how.
> Oops, I've forgot about the merge window. Thank you very much for your
> kind answer.
> Sorry if I bothered you while you're in busy time.
> Because the build problem is not a big deal because it exists only in
> -next tree,
> I will wait until merge window be closed and then fix it again if it
> still exist.
>

I've already sent a patch that exports this and other clock provider
functions. Please use this one:

https://patchwork.kernel.org/patch/3507921/

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

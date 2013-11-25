From: olof@lixom.net (Olof Johansson)
Date: Mon, 25 Nov 2013 10:26:46 -0800
Subject: [PATCH v4 REPOST] ARM: vexpress/TC2: Implement MCPM
 power_down_finish()
In-Reply-To: <alpine.LFD.2.10.1311251259400.9667@knanqh.ubzr>
References: <1385396185-15291-1-git-send-email-Dave.Martin@arm.com>
 <CAOesGMjcNhqUikHhP-Jx5cHUocHQUTPW9p5ikwwQxbMSFM7hvQ@mail.gmail.com>
 <alpine.LFD.2.10.1311251259400.9667@knanqh.ubzr>
Message-ID: <CAOesGMgVud7hX-wDtywt9_gkCDcuCgyXbm+CQG1kxjfCthLK2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 10:02 AM, Nicolas Pitre
<nicolas.pitre@linaro.org> wrote:
> On Mon, 25 Nov 2013, Olof Johansson wrote:
>
>> Hi,
>>
>> > Since v3.13-rc1, mcpm backends must implement an additional method which
>> > the vexpress TC2 implementation doesn't have upstream, resulting in an
>> > ugly WARN_ON() during hotplug and kexec operations
>>
>> Please be more specific here. Which change in the 3.13 merge window caused this?
>
> Commit 0de0d6467525.
>
> The corresponding change to tc2-pm.c was initially posted at about the
> same time i.e. before the merge window, but it somehow fell into a
> crack.

Thanks, I'll add that reference to the patch description when I apply.

Looks like the MCPM-side patch was posted already back in Oct 1. I'm
not going to flame anyone over this, but it'd be nice if we could find
out about these things sooner, ideally when breakage hits -next. Dave,
next time I think I'd prefer to hear about it even if it is during the
merge window. :-)

Anyway, obviously it's needed and I'll apply it.


-Olof

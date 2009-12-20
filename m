From: cd2436@columbia.edu (Christoffer Dall)
Date: Sun, 20 Dec 2009 01:00:43 -0500
Subject: Early pl011 console for debugging KVM for ARM port
In-Reply-To: <20091217040232.GB2621@tarshish>
References: <7d08b87d0912161725h424dc1c3s3c219f7138d61208@mail.gmail.com>
	<20091217040232.GB2621@tarshish>
Message-ID: <7d08b87d0912192200p17d319cbia2256db906acb210@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch.

Got side tracked for a few days.

Thanks a lot. It works like a charm. I now know that the error happens
in different places on each execution, and I'm debugging that now.

Best,
Christoffer

On Wed, Dec 16, 2009 at 11:02 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> Hi Christoffer,
>
> On Wed, Dec 16, 2009 at 08:25:29PM -0500, Christoffer Dall wrote:
>> Does anyone know how to enable such a console earlier?
>
> The early_printk commit, which has recently been merged to the mainline, may
> help you. See commit 93fd03a8c6728b58879f8af20ffd55d9c32a778b and the link
> below.
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=93fd03a8c6728b58879f8af20ffd55d9c32a778b
>
> baruch
>
> --
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ~. .~ ? Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
> ? - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
>

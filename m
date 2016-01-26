From: rogershimizu@gmail.com (Roger Shimizu)
Date: Tue, 26 Jan 2016 19:06:16 +0900
Subject: [PATCH v3] ARM: dts: kirkwood: add device tree for buffalo
 linkstation ls-qvl
In-Reply-To: <87vb6hd0hh.fsf@free-electrons.com>
References: <1453652964-21489-1-git-send-email-rogershimizu@gmail.com>
 <1453740250-16765-1-git-send-email-rogershimizu@gmail.com>
 <87zivtd21i.fsf@free-electrons.com>
 <CAEQ9gEnqgi01E0nE3Yw_8gTGe-_1+T3=HgPKNAcjDD+c2AP=bw@mail.gmail.com>
 <87vb6hd0hh.fsf@free-electrons.com>
Message-ID: <CAEQ9gEk0Z-Zgm1aqVQaYRpWVp35VcC2sVAH9Qz+1kCMHHYLWkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[lists seems rejected my previous email, so re-send]

Dear Gregory,

On Tue, Jan 26, 2016 at 2:37 AM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Roger,
>
>  On lun., janv. 25 2016, Roger Shimizu <rogershimizu@gmail.com> wrote:
>
>> On Tue, Jan 26, 2016 at 2:03 AM, Gregory CLEMENT
>> <gregory.clement@free-electrons.com> wrote:
>>>
>>> Thanks for all your work, I was about to apply it but as I already
>>> applied your previous patches I didn't manage to do it.
>>>
>>>
>>> Would you mind rebasing your patch on the mvebu/dt branch that I have
>>> just push on git://git.infradead.org/linux-mvebu.git ?

I find you missed one of my patches on "mvebu/dt" branch:

>   - [patch 7/7] split dts for lswvl [0]

[0]: http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/400937.html

For that ls-wvl patch, "git am <patch 07>" would fail,
but after "patch -p1 < .git/rebase-apply/patch", and then "git add -A;
git am --continue", that patch can be applied.
After that, I can successfully apply this ls-qvl patch.

I'm not sure whether you use "git am" to apply patches.
Maybe you use other similar ways. Please try and let me know if still
need my rebase.
Thank you!

Cheers,
Roger
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 17B3ACB1

From: rogershimizu@gmail.com (Roger Shimizu)
Date: Tue, 26 Jan 2016 19:36:48 +0900
Subject: [PATCH v3] ARM: dts: kirkwood: add device tree for buffalo
 linkstation ls-qvl
In-Reply-To: <87a8nsd4uk.fsf@free-electrons.com>
References: <1453652964-21489-1-git-send-email-rogershimizu@gmail.com>
 <1453740250-16765-1-git-send-email-rogershimizu@gmail.com>
 <87zivtd21i.fsf@free-electrons.com>
 <CAEQ9gEnqgi01E0nE3Yw_8gTGe-_1+T3=HgPKNAcjDD+c2AP=bw@mail.gmail.com>
 <87vb6hd0hh.fsf@free-electrons.com>
 <CAEQ9gEk0Z-Zgm1aqVQaYRpWVp35VcC2sVAH9Qz+1kCMHHYLWkw@mail.gmail.com>
 <87a8nsd4uk.fsf@free-electrons.com>
Message-ID: <CAEQ9gEn11D261BDMpKyn9H2gHjnWbsys4a+dLoOCsHo5Xxqx5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 7:15 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
>  On mar., janv. 26 2016, Roger Shimizu <rogershimizu@gmail.com> wrote:
>> For that ls-wvl patch, "git am <patch 07>" would fail,
>> but after "patch -p1 < .git/rebase-apply/patch", and then "git add -A;
>> git am --continue", that patch can be applied.
>> After that, I can successfully apply this ls-qvl patch.
>>
>> I'm not sure whether you use "git am" to apply patches.
>> Maybe you use other similar ways. Please try and let me know if still
>> need my rebase.
>
> Usually I applied the patch directly from emacs, which call a kind of
> git am. However your patches did not apply directly, I had to reduce the
> context by using git am -C2. I did it for the patch 5 and 6, and I
> forgot ot do it for patch 7. Now it is done and indeed this patch
> applied well ontop of it.

Learned that "git am" can try -C2 when there's small conflicts.
And glad to hear that all my work got applied well.
Thank you!

Cheers,
Roger

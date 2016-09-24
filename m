From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Sep 2016 20:02:46 -0500
Subject: [PATCH 0/2] i2c: meson: add gxbb compatible string
In-Reply-To: <20160923232641.GB5683@katana>
References: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
 <20160915194146.GB7863@katana>
 <CAL_JsqKNFzo6RWJO5WOvsyO3e4UTo5Zn48aaDac=+uL_CQWerQ@mail.gmail.com>
 <20160923221312.GA5683@katana>
 <CAL_JsqKi9Dk5-nF9xFD-89TTUinaGjMv5s1=N2b-Xyu98b+S3w@mail.gmail.com>
 <20160923232641.GB5683@katana>
Message-ID: <CAL_JsqJGQ2az=eO0PbfcTrAPxUsym=UaDOOy1Rsw0-AbzMjnXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 6:26 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > I intentionally don't ask people to send me the patches squashed. So,
>> > you will have them seperate in patchwork et al. I only squash them just
>> > before commiting to my tree. That's because I found that when digging
>> > through git history, it is much more convenient to have all the
>> > information in one commit.
>>
>> If git history was the only thing that mattered, then that would be
>> fine. But it is not. Maintainers should apply what's on the list.
>> Period.
>
> Huh? If you would *ask* me to stop squashing, I am listening to reasons.

I did state some reasons previously. Consistent rules for submitters
of DT bindings and being able to trace history beyond git. Now, I
guess you aren't changing the rules, but you probably aren't
requesting people to split DT bindings either? You might not be aware,
but we also generate a DT only tree with git-filter-branch[1] for
non-kernel projects to use bindings and dts files. For that, sure they
will only get the DT binding part of it, but what commit text do they
get? Finally, DT maintainer acks (which from me is a review really)
apply to the bindings only. Sometimes I review the drivers, but not
often. So I would like the git history of my reviews to be accurate in
terms of what I actually reviewed.

> If you want to force arbitrary rules on me, I am not. There are reasons
> where squashing/modifying patches makes more sense compared to forcing
> the author to resend. DTS bindings may not be one, we can discuss that.
> But that rule without allowing exceptions seems impractical to me.

Okay, "period" was a bit much. Exceptions are perfectly fine, we all
do some minor fixups time to time. It just shouldn't be the norm IMO.

Rob

[1] https://git.kernel.org/cgit/linux/kernel/git/devicetree/devicetree-rebasing.git/

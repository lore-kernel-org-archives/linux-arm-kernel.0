From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 24 Sep 2016 10:41:54 +0200
Subject: [PATCH 0/2] i2c: meson: add gxbb compatible string
In-Reply-To: <CAL_JsqJGQ2az=eO0PbfcTrAPxUsym=UaDOOy1Rsw0-AbzMjnXg@mail.gmail.com>
References: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
 <20160915194146.GB7863@katana>
 <CAL_JsqKNFzo6RWJO5WOvsyO3e4UTo5Zn48aaDac=+uL_CQWerQ@mail.gmail.com>
 <20160923221312.GA5683@katana>
 <CAL_JsqKi9Dk5-nF9xFD-89TTUinaGjMv5s1=N2b-Xyu98b+S3w@mail.gmail.com>
 <20160923232641.GB5683@katana>
 <CAL_JsqJGQ2az=eO0PbfcTrAPxUsym=UaDOOy1Rsw0-AbzMjnXg@mail.gmail.com>
Message-ID: <20160924084154.GA1434@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I did state some reasons previously. Consistent rules for submitters
> of DT bindings and being able to trace history beyond git. Now, I
> guess you aren't changing the rules, but you probably aren't
> requesting people to split DT bindings either? You might not be aware,
> but we also generate a DT only tree with git-filter-branch[1] for
> non-kernel projects to use bindings and dts files. For that, sure they
> will only get the DT binding part of it, but what commit text do they
> get? Finally, DT maintainer acks (which from me is a review really)
> apply to the bindings only. Sometimes I review the drivers, but not
> often. So I would like the git history of my reviews to be accurate in
> terms of what I actually reviewed.

Points taken. Will keep them seperate from now on.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160924/b82a4946/attachment-0001.sig>

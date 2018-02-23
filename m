From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 23 Feb 2018 08:52:20 +0100
Subject: [PATCH 1/4] dt-bindings: at24: sort manufacturers alphabetically
In-Reply-To: <20180221094009.2zql6gbzkcklbakk@ninjato>
References: <20180116160618.27859-1-peda@axentia.se>
 <20180116160618.27859-2-peda@axentia.se>
 <20180129161727.g4kdrr5sih22vs5a@rob-hp-laptop>
 <CAMRc=Mcqj36KP7dG71dzSn_7cxw-Tru5kNtXdr5-SiH=jbCfMA@mail.gmail.com>
 <20180221091130.4sdfnalrng4sd77i@ninjato>
 <CAMRc=Mfcvh3PoF46DvU8RiVZ2bnQPkRm=pmv9MPEux1sHpnAOw@mail.gmail.com>
 <20180221094009.2zql6gbzkcklbakk@ninjato>
Message-ID: <CAMRc=MdE_LX276mjXCHaNgAthKyzaKPW-eWBfEuCcG187X7wvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-02-21 10:40 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
>
>> Will do. What about this (http://patchwork.ozlabs.org/patch/867169/)
>> one? It's part of a bigger series, do you want me to apply it to my
>> tree and provide you with an immutable branch?
>
> Well, I would accept it for 4.16 using the "plain new id" rule. So, if
> you add it on top of Peter's sorting patch, totally fine by me.
>
> If you want it in v4.17, ok, too. I'd think an immutable branch is not
> needed. There is a fallback property in the DTS. So at worst, there will
> be a DTS warning during the merge window which will be fixed at rc1 time.
>
> Unless I overlooked something.
>

Ok, I'll have some time during the weekend, so I'll send a PR for rc3.

Bart

From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 21 Feb 2018 10:40:09 +0100
Subject: [PATCH 1/4] dt-bindings: at24: sort manufacturers alphabetically
In-Reply-To: <CAMRc=Mfcvh3PoF46DvU8RiVZ2bnQPkRm=pmv9MPEux1sHpnAOw@mail.gmail.com>
References: <20180116160618.27859-1-peda@axentia.se>
 <20180116160618.27859-2-peda@axentia.se>
 <20180129161727.g4kdrr5sih22vs5a@rob-hp-laptop>
 <CAMRc=Mcqj36KP7dG71dzSn_7cxw-Tru5kNtXdr5-SiH=jbCfMA@mail.gmail.com>
 <20180221091130.4sdfnalrng4sd77i@ninjato>
 <CAMRc=Mfcvh3PoF46DvU8RiVZ2bnQPkRm=pmv9MPEux1sHpnAOw@mail.gmail.com>
Message-ID: <20180221094009.2zql6gbzkcklbakk@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Will do. What about this (http://patchwork.ozlabs.org/patch/867169/)
> one? It's part of a bigger series, do you want me to apply it to my
> tree and provide you with an immutable branch?

Well, I would accept it for 4.16 using the "plain new id" rule. So, if
you add it on top of Peter's sorting patch, totally fine by me.

If you want it in v4.17, ok, too. I'd think an immutable branch is not
needed. There is a fallback property in the DTS. So at worst, there will
be a DTS warning during the merge window which will be fixed at rc1 time.

Unless I overlooked something.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180221/cc305d42/attachment.sig>

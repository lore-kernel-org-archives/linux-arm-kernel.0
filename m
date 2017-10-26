From: ndesaulniers@google.com (Nick Desaulniers)
Date: Thu, 26 Oct 2017 14:41:11 -0700
Subject: [PATCH] arm64: prevent regressions in compressed kernel image
 size when upgrading to binutils 2.27
In-Reply-To: <CAKwvOdmZgzBneocuhhLs5YRwZv3JUvnSJSPi5pFCZbrkdNzc5w@mail.gmail.com>
References: <20171026202907.91852-1-ndesaulniers@google.com>
 <CAKv+Gu80ub1PnibzBtjPSOusHD-6oj4A=7ZeuW5VTv3aDQrdnQ@mail.gmail.com>
 <CAKwvOd=4=GOPUSYUzwkXHV2xhTzUnEpbw4c_PmFiqZBjbV80jA@mail.gmail.com>
 <CAKwvOdnemSgO1Jp9B1ANhnNfu8f2xAh+wJiaLQVSAREdck3cCA@mail.gmail.com>
 <CAFrQcG_znedMpcvXQkcDZ96ti66y9H8AEfcqVjgnZMwW1ViRdg@mail.gmail.com>
 <CAKwvOdmZgzBneocuhhLs5YRwZv3JUvnSJSPi5pFCZbrkdNzc5w@mail.gmail.com>
Message-ID: <CAKwvOdnE_owxGZgYvh1TvA50Hn7nk=9-3YFn6K59aO7khue4Cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, Oct 26, 2017 at 1:41 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:>are seeded with the correct values,
I propose we simply drop the outer

> On Thu, Oct 26, 2017 at 2:17 PM, Siqi Lin <siqilin@google.com> wrote:
>> I'm OK with sticking with the <2.27 binutils behavior. The gzip data is:

> ... Nick:
> That's what this patch does; goes back to the <2.27 behavior for 2.27+.

Sorry, rereading this thread, it sounds like neither of you were
disagreeing with me?  Will post v2.

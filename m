From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Feb 2017 10:43:12 +0100
Subject: [GIT PULL 1/7] ARM: SoC non-urgent fixes for merge window
In-Reply-To: <CA+55aFy6ZpXsRjz9mAV+wxg7Okq3FEkZvR69niPb7m1Vu=7xbQ@mail.gmail.com>
References: <8729461.VkrRdW7LzJ@wuerfel> <9013724.FUQHNQsY9n@wuerfel>
 <CA+55aFy6ZpXsRjz9mAV+wxg7Okq3FEkZvR69niPb7m1Vu=7xbQ@mail.gmail.com>
Message-ID: <CAK8P3a25-2XdYAJnisSF8cxjyoPwNa_ajTGGAzxFXQaMqwSCVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2017 at 12:33 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Feb 23, 2017 at 3:05 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes-nc
>
> Interesting. So I'm pulling this, and I get to pull request 3/7, and
> that's when I notice that the email is sent by Arnd, but the tag is
> signed by Olof.
>
> Which is fine, but I end up cutting-and-pasting the name of the "from"
> person from the signature, so the pull requests got merged as
>
>    Pull ARM SoC ... from Olof Johansson:
>
> instead or using "from Arnd Bergmann".
>
> I guess it doesn't matter and you guys don't care, but I ended up
> re-doing the pulls. Olof gets credit in the pgp signature anyway.
>
> I wonder how many times before you guys have done this and I just
> didn't notice the ambiguity of who I should credit.

We really don't care, as we don't split the work by topic branches but
rather according to who gets the job done on a given day. Any given
branch likely contains work from both of us and the signature is
from whoever wrote the text is in the tag.

This merge window, Olof did most of the merges and he also started
writing up the tag descriptions for some branches, but I finished the
job while he was attending ELC. This is probably the first time
you got pull request with tags signed by more than one of us, but
IIRC we had one merge window where all the signatures came from
one person and the pull request was sent by the other, and one time
(long ago) I created a signed tag that pointed to a tag that Olof had
signed rather than a tree object. That looked very odd in git, so I
decided not to do that again.

If we ever get into the same situation again, with the signature
coming from someone other than the person sending the mail, I'll
try to explain that in the mail.

    Arnd

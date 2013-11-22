From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 22 Nov 2013 15:48:24 -0800
Subject: crypto dependency in bit sliced AES
In-Reply-To: <20131122225256.GG16735@n2100.arm.linux.org.uk>
References: <CAKv+Gu8PESZ3uFZ6Rf+sma9QeRd7xSyrEa=RVCeDR1KtmLKEAA@mail.gmail.com>
 <20131122225256.GG16735@n2100.arm.linux.org.uk>
Message-ID: <CA+55aFwRWGdA934GQdo6QpEuxRxeECvrpi9ctJWcVQ5pCyF1iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 2:52 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 22, 2013 at 11:09:00PM +0100, Ard Biesheuvel wrote:
>> Hello Russell,
>>
>> To my surprise, Linus has decided to release 3.13-rc1 without honoring
>> Herbert's crypto pull requests for 3.13
>>
>> http://marc.info/?l=linux-crypto-vger&m=138381130023859&w=2
>> http://marc.info/?l=linux-crypto-vger&m=138482768727213&w=2
>>
>> which contain my patch 'crypto: create generic version of ablk_helper'
>
> That's annoying.  Linus, is there any chance that this missed pull
> request could happen?  It's clearly been missed for what ever reason.

So looking through my emails, I don't have it, but since it clearly
made it to lkml, I accept that Herbert sent it to me in time. It
probably got eaten as spam, I think we've had that issue with Herbert
before.

Herbert, any idea why gmail would consider your emails spam? Mind
re-sending it once more, and I'll try to see if I get it..

I actually see an email from Herbert *replying* to Borislav in my
archives, but I do not see the pull request emails themselves.

              Linus

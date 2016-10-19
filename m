From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 19 Oct 2016 09:01:33 -0700
Subject: Build failure with v4.9-rc1 and GCC trunk -- compiler weirdness
In-Reply-To: <20161019155658.GB4411@x4>
References: <20161017183806.GG5601@arm.com> <20161019153746.GA4411@x4>
 <CA+55aFzSi4V9ZYDfxvZNfz1ogngTywW5Q9U_vQq3v83+0wgPrA@mail.gmail.com>
 <20161019155658.GB4411@x4>
Message-ID: <CA+55aFx=ZX=7u07R6zJ7fSw=zSQNaYqVX7R3LQs4riiEf+uA=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 8:56 AM, Markus Trippelsdorf
<markus@trippelsdorf.de> wrote:
> On 2016.10.19 at 08:55 -0700, Linus Torvalds wrote:
>>
>> Well, in the meantime we apparently have to live with it. Unless Will
>> is using some unreleased gcc version that nobody else is using and we
>> can just ignore it?
>
> Yes, he is using gcc-7 that is unreleased. (It will be released April
> next year.)

Ahh, self-built? So it's not part of some experimental ARM distro
setup and this will be annoying lots of people?

If so, still think that we could just get rid of the ____ilog2_NaN()
thing as it's not _that_ important, but it's certainly not very
high-priority. Will can do it in his tree too for testing, and it can
remind people to get the gcc problem fixed.

              Linus

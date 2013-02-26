From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 25 Feb 2013 19:35:24 -0800
Subject: what's the next LTSI kernel version for long-term support
In-Reply-To: <CAGsJ_4yxQK05hHUivYEnLD9=cAE4t5jNV7+6KJGu+LsVsSk1oQ@mail.gmail.com>
References: <CAGsJ_4yxQK05hHUivYEnLD9=cAE4t5jNV7+6KJGu+LsVsSk1oQ@mail.gmail.com>
Message-ID: <20130226033524.GA25067@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 11:06:56AM +0800, Barry Song wrote:
> Hi Greg/All,
> we have seen 3.4 was announced to be an LTSI in Aug, 2012. I'd like to
> know what is the next LTSI version since we might want to align our
> next release with LTSI.

Who is "we" here?

> That might help us to plan the release cycle.

As I've stated before, I do not announce the long-term kernel ahead of
time, we did that once in the past and it was a total mess.  I announce
it _after_ the kernel is released.

I have also stated that 3.8 is NOT going to be a long-term kernel, that
would mean I would be handling 3 long-term kernels at once, plus 1-2
"normal" stable kernels.  That is a sure way to drive me crazy and burn
out.

> BTW, how many people and SoC vendors in ARM communicaty want to align
> your releases with LTSI?

I do not know.  There was an LTSI meeting last week at ELC where this
was discussed, I suggest you ask the people who attended it. I was
there, but it's not up to me to release the meeting minutes, and I
wasn't taking notes, sorry.

thanks,

greg k-h

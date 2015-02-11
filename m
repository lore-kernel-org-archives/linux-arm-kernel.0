From: hjl.tools@gmail.com (H.J. Lu)
Date: Wed, 11 Feb 2015 11:22:14 -0800
Subject: [musl] Re: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <20150211190537.GK32724@port70.net>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <20150210181302.GA23886@brightrain.aerifal.cx>
 <20150211173919.GF9058@e104818-lin.cambridge.arm.com>
 <20150211190537.GK32724@port70.net>
Message-ID: <CAMe9rOrOR9yyYeWL07K0mwzEUD4Dd_2Ew4ntwqEZfS+4TJ5naw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 11:05 AM, Szabolcs Nagy <nsz@port70.net> wrote:
> i know at least one android kernel issue: there is an ioctl for the
> alarm device that takes timespec argument
>
> (i think it's not in the mainline kernel and i guess android does
> not care about x32 so it was not an issue so far, but this is something
> that should not be fixed on the libc side)
>

I have documented some remaining x32 kernel issues at:

https://sites.google.com/site/x32abi/

-- 
H.J.

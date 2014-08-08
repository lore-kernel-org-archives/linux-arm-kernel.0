From: olof@lixom.net (Olof Johansson)
Date: Fri, 8 Aug 2014 13:37:16 -0700
Subject: [GIT PULL 0/7] ARM: SoC changes for 3.17
In-Reply-To: <CAL_JsqLgRM8_62mz3HCcsE6vw0gtB3pN0rg6SExnZvnOTRNu2g@mail.gmail.com>
References: <1407516479-1251-1-git-send-email-olof@lixom.net>
 <CAL_JsqLgRM8_62mz3HCcsE6vw0gtB3pN0rg6SExnZvnOTRNu2g@mail.gmail.com>
Message-ID: <CAOesGMgB7FpXzj1iFU2tFW9O7L=tiQwTUm-0gAuLAHw+=2zPXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 8, 2014 at 1:03 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, Aug 8, 2014 at 11:47 AM, Olof Johansson <olof@lixom.net> wrote:
>> A moderately sized set of branches this merge window for us, about 750
>> patches in total. There are several fairly large cleanups, and a net
>> negative delta(!)
>>
>>  1014 files changed, 39452 insertions(+), 42425 deletions(-)
>
> If you look at mach-* and plat-* only, the overall delta has been
> negative mostly since 3.0 which was when ARM DT support went in. The
> overall size is trending down as well after growing by an order of
> magnitude. You're going to be out of a job soon (or DTS maintainer).
> ;)

Yeah, mach/plat contents has gone down for quite a while, but we've
been busy adding stuff like DTS contents and the like. I think might
had a few net-negative-in-total merge windows in the past, but they
haven't been all that common.


-Olof

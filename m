From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 May 2017 22:35:51 +0200
Subject: arm64 test_user_copy crash on copy_from_user(uptr, kptr, size)
In-Reply-To: <20170526154048.GB22865@leverpostej>
References: <CAK8P3a1tyU8J4VEWVwLOHWM+of9bnWvm+SXBxkfsZA7yfEei9A@mail.gmail.com>
 <20170526154048.GB22865@leverpostej>
Message-ID: <CAK8P3a0ZKGjHGTDj0cNcrFYp_oqHz0K1hCPJycB5TA1E9hAUrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 26, 2017 at 5:40 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, May 26, 2017 at 05:24:47PM +0200, Arnd Bergmann wrote:

> AFAICT, that test was disabled in commit:
>
>   f5f893c57e37ca73 ("usercopy: Adjust tests to deal with SMAP/PAN")
>
> ... or have I misunderstood?

I think you are right, my mistake for not checking the latest kernels
and only relying on the bug report that said it also happens on "mainline".

     Arnd

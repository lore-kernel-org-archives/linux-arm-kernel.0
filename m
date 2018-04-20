From: ndesaulniers@google.com (Nick Desaulniers)
Date: Fri, 20 Apr 2018 16:43:05 +0000
Subject: Clang arm64 build is broken
In-Reply-To: <8b3e95df-a429-2f84-565c-3caed8e30e28@arm.com>
References: <CAAeHK+wDMH_G=3UuGOda2t0g4TH4TmDAeyG-ydJwg9vmThd3eQ@mail.gmail.com>
 <c61336a2-7c66-ea48-3daa-e644403d7a6e@arm.com>
 <CAKwvOdnKuFuqoWKpVJqVa1u8A0z2+vQp9j7+TsNh9qz3Yitk-Q@mail.gmail.com>
 <8b3e95df-a429-2f84-565c-3caed8e30e28@arm.com>
Message-ID: <CAKwvOdmhNH4PYNwH+tsZc4uQQJVhOOHSph2YdDCHcyWNyFMxyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 9:36 AM Marc Zyngier <marc.zyngier@arm.com> wrote:

> On 20/04/18 17:30, Nick Desaulniers wrote:
> > On Fri, Apr 20, 2018 at 1:13 AM Marc Zyngier <marc.zyngier@arm.com>
wrote:
> >> Clang isn't
> >> really supported to build the arm64 kernel anyway
> >
> > Can you expand on this?  There are millions of arm64 devices shipping
with
> > Clang built Linux kernels.

> How many of these devices run a full-featured mainline kernel?

> Sure, Android is building the kernel with clang, but that's with a pile
> of out of tree patches. At that point, I'm not sure we're talking about
> the same arm64 kernel.

Do you recommend that we only work with ARM licensed SoC vendors with no
out of tree patches?

--
Thanks,
~Nick Desaulniers

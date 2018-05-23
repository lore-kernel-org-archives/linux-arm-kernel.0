From: andreyknvl@google.com (Andrey Konovalov)
Date: Wed, 23 May 2018 13:54:06 +0200
Subject: [PATCH] arm64: kvm: use -fno-jump-tables with clang
In-Reply-To: <CAKwvOdmWg8o9yoZ+3dCwL8vYB8gzE+AatCbXENN-+Gge9Q6gtA@mail.gmail.com>
References: <20180518170202.11458-1-samitolvanen@google.com>
 <05d14ac7-0feb-63a3-e7ef-b8ca1ae2fd1d@arm.com>
 <CAKwvOdm1kYedukCq=g74AvqJHp6KC03oNoouQy2nkvfo4idoEw@mail.gmail.com>
 <8c7be44f-086d-65e3-9969-8182261ce82f@arm.com>
 <CAKwvOd=XZqg5=mkXZb-cxq3i_AGoJGAbmF=Fwc7Q98oi0tbN9g@mail.gmail.com>
 <3fd89842-86cd-ee01-0c2c-5438dd2d5f2a@arm.com>
 <CAKwvOdk+=JKcQP1ieLEkZftRGf-pqCTTzEuYvT_45YNMkEw_wA@mail.gmail.com>
 <86k1rzc4ba.wl-marc.zyngier@arm.com>
 <CAAeHK+z2LmMYasYtRTt2U=QF8Pe_i10RA3-SkLzGXXByZqLh1w@mail.gmail.com>
 <CAKwvOdmWg8o9yoZ+3dCwL8vYB8gzE+AatCbXENN-+Gge9Q6gtA@mail.gmail.com>
Message-ID: <CAAeHK+wk0hSH6iQcsLzrpjvsGocev-UZ6=z95ysecdFnAcHVSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 8:28 PM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> On Fri, May 18, 2018 at 11:13 AM Marc Zyngier <marc.zyngier@arm.com> wrote:
>> > - you have checked that with a released version of the compiler, you
>
> On Tue, May 22, 2018 at 10:58 AM Andrey Konovalov <andreyknvl@google.com>
> wrote:
>> Tested-by: Andrey Konovalov <andreyknvl@google.com>
>
> Hi Andrey,
> Thank you very much for this report.  Can you confirm as well the version
> of Clang that you were using?

I'm on 86852a40 ("[InstCombine] Calloc-ed strings optimizations").

> If it's not a binary release (built from
> source), would you be able to re-confirm with a released version?

Sure. Which release should I try and how do I get it?

From: alexey.zaytsev@gmail.com (Alexey Zaytsev)
Date: Thu, 17 May 2012 18:29:23 +0300
Subject: A good sub-architecture to base new ports on?
In-Reply-To: <201205161557.45362.arnd@arndb.de>
References: <CAB9v_DFdTkAFQWFthLncx5frJX0jed11CUoKXJDT-ac6j3hWOQ@mail.gmail.com>
 <201205161557.45362.arnd@arndb.de>
Message-ID: <CAB9v_DE-FRdyutcZL7EMpTv-9rXqoi+V15T_WyeP9CggrcMZdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 6:57 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 16 May 2012, Alexey Zaytsev wrote:
>> Hey.
>>
>> With all the ARM tree rework, I'm wondering, what would be a good (and
>> simple) sub-architecture on which to base new ports. The target is a
>> somewhat dated chip used in ADSL routers, so no DT, or multiplatform.
>> I'm looking at ixp4xx, because I'm somewhat familiar with the
>> platform, but is it a good reference?
>

Thanks for the reply.

> For a new subarchitecture, using DT is required, but it should not make
> your work harder. spear3xx/6xx is a good example of an older platform
> that was recently converted (take the arm-soc tree as a base, it contains
> the latest version).

Will do. Thanks for the arm-soc pointer.

> Another good one would be highbank, but that contains a lot of stuff you
> don't need.
>
> ixp4xx is not very actively maintained, so I would not use that as
> a base.
>
> What platform are you talking about? I know of a few people that are
> working on getting older platforms ported to Linux, so maybe someone
> is already working on a port.

It's a 'Solos' soc from Connexant. They released kernel code for
2.6.11, and I'm up-porting it to the current kernel. I know at least
two other people interested in the port, adding them to CC. If you
know anyone else, it would be great to share the effort.

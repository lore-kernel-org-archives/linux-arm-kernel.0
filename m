From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Thu, 30 Nov 2017 10:57:20 +0100
Subject: [PATCH v3 0/6] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <CAK8P3a3uWpe6HBtt-XPW0H_VTjes-GpSouvs4JHXmQ2ZcvhsEg@mail.gmail.com>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171130004510.23887-1-lukma@denx.de>
 <CAK8P3a3uWpe6HBtt-XPW0H_VTjes-GpSouvs4JHXmQ2ZcvhsEg@mail.gmail.com>
Message-ID: <1512035840.1465.6.camel@Nokia-N900>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd!

On Thu Nov 30 10:02:26 2017 Arnd Bergmann <arnd@arndb.de> wrote:
> Can we clarify who is picking up ep93xx patches these days? The
> last time I think Linus Walleij offered to do it for the 4.14 merge
> window, as neither Hartley nor Alexander had a git tree.
> 
> I don't care too much who does it in the end, between Hartley, Alexander,
> Linus and even Lukasz directly, but I'd like whoever feels responsible
> for the platform to be listed in the MAINTAINERS file and pick up
> the patches from everyone else to forward them to me as either
> pull requests or separate patches to arm at kernel.org when the
> patches are ready, so I don't have to make a decision about when to
> pick them up from the list.

As I stepped in as a maintainer there was a common understanding, that ep93xx is so inactive these days, that is doesn't deserve a separate tree. But I feel also that we will benefit from one, so let me create one this evening and I'll send you pull request when we agree with Lukasz. Just let me know if you'd be fine with github or should I care about kernel.org?

--
Regards,
Alexander.

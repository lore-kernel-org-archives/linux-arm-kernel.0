From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Mar 2017 12:31:50 +0000
Subject: mainline build: 208 builds: 0 failed, 208 passed, 422 warnings
 (v4.11-rc2-164-gdefc7d752265)
In-Reply-To: <CAK8P3a1jHhM=80Zo59JoDNd2RKwTfdR_i61_=ASqqUeJ1oecxg@mail.gmail.com>
References: <58c97f8f.c4b5190a.8c4e4.300d@mx.google.com>
 <CAK8P3a1jHhM=80Zo59JoDNd2RKwTfdR_i61_=ASqqUeJ1oecxg@mail.gmail.com>
Message-ID: <20170320123150.GJ17263@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 09:02:06PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 15, 2017 at 6:53 PM, kernelci.org bot <bot@kernelci.org> wrote:
> >
> > mainline build: 208 builds: 0 failed, 208 passed, 422 warnings (v4.11-rc2-164-gdefc7d752265)
> 
> The last build failure in mainline is gone now, though I don't know
> what fixed it.
> Let's hope this doesn't come back as the cause was apparently a race condition
> in Kbuild that might have stopped triggering.
> 
> > Warnings summary:
> > 409 :1325:2: warning: #warning syscall statx not implemented [-Wcpp]
> 
> The warning triggers for arm, arm64 and mips on every build. I saw a patch
> was posted for asm-generic, which takes care of arm64.
> 
> Catalin and Will: can you take this through the arm64 tree? I don't have
> anything else for asm-generic at the moment.

Yes, I'll pick that up.

Will

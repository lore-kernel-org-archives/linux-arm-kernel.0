From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 2 May 2017 10:55:10 +0200
Subject: linux-next: build failure after merge of the drm-misc tree
In-Reply-To: <20170502184132.2c1b0299@canb.auug.org.au>
References: <20170421121014.3ee14a83@canb.auug.org.au>
 <20170424112512.582d04da@canb.auug.org.au>
 <20170502082518.jdk5tqjhvlsqntny@phenom.ffwll.local>
 <20170502184132.2c1b0299@canb.auug.org.au>
Message-ID: <CAK8P3a0AqL1nZrmaBaHNJ0Nfji72Lm44DPPSoKzGFbd4FcQHFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 2, 2017 at 10:41 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Daniel,
>
> On Tue, 2 May 2017 10:25:18 +0200 Daniel Vetter <daniel@ffwll.ch> wrote:
>>
>> Since this is an all-new driver it might be best to stagger the pull
>> requests and merge the new tee subsystem (or whatever it is) after drm?
>>
>> Not sure what to best do here ...
>
> This will merge via Dave, so Dave just needs to let Linus know that a
> fix up is needed when this merges with the arm-soc stuff in Linus' tree.

The TEE subsystem is currently on a separate branch by itself in arm-soc,
so we could easily delay that until DRM is in, and point out the resolution
here.

       Arnd

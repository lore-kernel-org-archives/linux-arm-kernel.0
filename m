From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 May 2017 17:52:55 +0200
Subject: [PATCH] drm/pl111: add ARM_AMBA dependency
In-Reply-To: <87pof07de3.fsf@eliezer.anholt.net>
References: <20170522152058.3346428-1-arnd@arndb.de>
 <878tlolv1z.fsf@eliezer.anholt.net>
 <CAK8P3a3UjWM0OGVO1nNyEtrRUyFKDuBOboYVSnVLcg4MTKfFMQ@mail.gmail.com>
 <87pof07de3.fsf@eliezer.anholt.net>
Message-ID: <CAK8P3a0b5yHFWpO1K2TxQNP2s4=HjZC+KvoP_Qw9+HPO_hThAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 12:08 AM, Eric Anholt <eric@anholt.net> wrote:

>
> Oh, yeah, we've eliminated the amba_request_regions() that used to be
> why the probe had to be under the #ifdef, so your solution would get us
> better coverage and simpler code.  If you could send that patch to
> dri-devel today, I'll get it applied.

Sent now. I'll also send the oneline patch for s3c64xx separately, in case
we hit the same circular dependency another time.

        Arnd

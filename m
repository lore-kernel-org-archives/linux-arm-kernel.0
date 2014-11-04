From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 4 Nov 2014 20:18:59 +0000
Subject: [RFC PATCH] make CONFIG_STRICT_DEVMEM a core non-debug feature
In-Reply-To: <CAGXu5jJnaAFMUBR50TgapRzRcvKS0j=XO7u9z6fdNouwMb=_sQ@mail.gmail.com>
References: <1415121836-16241-1-git-send-email-leif.lindholm@linaro.org>
 <CAGXu5jL1BBAvoxVqFa1YHJSMCbGdLiPey-dyC15YKVPB2xGfig@mail.gmail.com>
 <20141104195914.GY22224@bivouac.eciton.net>
 <CAGXu5jJnaAFMUBR50TgapRzRcvKS0j=XO7u9z6fdNouwMb=_sQ@mail.gmail.com>
Message-ID: <20141104201859.GZ22224@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 12:02:32PM -0800, Kees Cook wrote:
> > I considered doing that, but didn't want to risk listing too many
> > details of one architecture, and too few of others.
> 
> Well, the others only say "memory mapped peripherals", so that's what
> I was suggesting adding the x86 language: it was the most detailed
> about what that would really mean to the end-user.

The problem is that this currently isn't strictly speaking true for
some architectures (at least not arm*). Without a standardised memory
map, we are exposing mapping anything not system RAM.

(Patches related to that will follow later this month.)

/
    Leif

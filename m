From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 13 May 2015 13:39:44 -0700
Subject: regression with today's linux-next
In-Reply-To: <20150513182738.GA28201@saruman.tx.rr.com>
References: <20150513182738.GA28201@saruman.tx.rr.com>
Message-ID: <CAMAWPa8U_ESvBUV5fvoFcRLtP5nK0qkVEtA+x7Xa_xUTG1ho_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 11:27 AM, Felipe Balbi <balbi@ti.com> wrote:

> your commit 9451980a6646 (net: Use cached copy of pfmemalloc to avoid
> accessing page) regresses most OMAP-based boards with a NULL pointer
> dereference.
>
> Below you can find git bisect log and a serial console capture of the
> problem.

FWIW, I can confirm the boot failure and had bisected down to the same commit.

Kevin

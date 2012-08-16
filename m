From: andi@firstfloor.org (Andi Kleen)
Date: Fri, 17 Aug 2012 00:17:58 +0200
Subject: [GIT PULL] Update LZO compression
In-Reply-To: <CAPkEcwgv6f5B+Mrw7kzrHcZ5JZ+Yr0o=bLdoFqCB-e4CLiVx5A@mail.gmail.com>
References: <50299142.2030504@oberhumer.com>
 <20120814123937.GA14756@sig21.net> <502B8FE3.7080501@oberhumer.com>
 <20120815144539.GA8300@sig21.net> <502C92C3.7090701@oberhumer.com>
 <20120816150647.GA22010@sig21.net> <20120816232549.4d14a6aa@natsu>
 <20120816175234.GL11413@one.firstfloor.org>
 <CAMuHMdWK_Y=QwkgQD6K8tFBLaO04Fy0yVAzEpb2OYW6Ec0hGoA@mail.gmail.com>
 <CAPkEcwgv6f5B+Mrw7kzrHcZ5JZ+Yr0o=bLdoFqCB-e4CLiVx5A@mail.gmail.com>
Message-ID: <20120816221758.GM11413@one.firstfloor.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 11:55:06AM -0700, james northrup wrote:
> looks like ARM results are inconclusive from a lot of folks without
> bandwidth to do a write-up, what about just plain STAGING status for ARM so
> the android tweakers can beat on it for a while?

Staging only really works for new drivers, not for updating existing
library functions like this.

I suppose you could keep both and have the architecture select with a
CONFIG.

-Andi

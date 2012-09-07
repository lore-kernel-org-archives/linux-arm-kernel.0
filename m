From: andi@firstfloor.org (Andi Kleen)
Date: Fri, 07 Sep 2012 14:31:12 -0700
Subject: [GIT PULL] Update LZO compression
In-Reply-To: <CAPkEcwgv6f5B+Mrw7kzrHcZ5JZ+Yr0o=bLdoFqCB-e4CLiVx5A@mail.gmail.com>
 (james northrup's message of "Thu, 16 Aug 2012 11:55:06 -0700")
References: <50299142.2030504@oberhumer.com>
 <20120814123937.GA14756@sig21.net> <502B8FE3.7080501@oberhumer.com>
 <20120815144539.GA8300@sig21.net> <502C92C3.7090701@oberhumer.com>
 <20120816150647.GA22010@sig21.net> <20120816232549.4d14a6aa@natsu>
 <20120816175234.GL11413@one.firstfloor.org>
 <CAMuHMdWK_Y=QwkgQD6K8tFBLaO04Fy0yVAzEpb2OYW6Ec0hGoA@mail.gmail.com>
 <CAPkEcwgv6f5B+Mrw7kzrHcZ5JZ+Yr0o=bLdoFqCB-e4CLiVx5A@mail.gmail.com>
Message-ID: <m2mx114j1b.fsf@firstfloor.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

james northrup <northrup.james@gmail.com> writes:

> looks like ARM results are inconclusive from a lot of folks without bandwidth
> to do a write-up, what about just plain STAGING status for ARM so the android
> tweakers can beat on it for a while? ?

Again staging doesn't really work for a core library, it's more
for separate drivers.

FWIW we did some tests and the new library seems to be generally faster
on x86.

-Andi

-- 
ak at linux.intel.com -- Speaking for myself only

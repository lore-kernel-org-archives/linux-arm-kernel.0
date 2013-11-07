From: rusty@rustcorp.com.au (Rusty Russell)
Date: Thu, 07 Nov 2013 11:06:49 +1030
Subject: [PATCH 2/3] virtio: mmio: fix signature checking for BE guests
In-Reply-To: <1383648359.11540.1.camel@hornet>
References: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
 <1381502171-8187-3-git-send-email-marc.zyngier@arm.com>
 <1381740385.3247.6.camel@hornet> <87li1wb4k4.fsf@rustcorp.com.au>
 <87a9hja5aw.fsf@rustcorp.com.au> <1383648359.11540.1.camel@hornet>
Message-ID: <87ob5x6o9q.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pawel Moll <pawel.moll@arm.com> writes:
> On Tue, 2013-11-05 at 03:36 +0000, Rusty Russell wrote:
> This particular can is empty - all worms already escaped :-)

I just thought that if you wait for 1.0, it will always be
little-endian, and if the current qemu only supported little-endian your
life might be simpler inside qemu.  But I'm sure Marc doesn't want to
wait :)

> It's a bugfix, not changing anything for the existing hosts. So - yes
> please, do merge this one.

Done, thanks.

Cheers,
Rusty.

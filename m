From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Aug 2015 12:24:28 +0100
Subject: [PATCH 0/2] x86/KASAN updates for 4.3
In-Reply-To: <CAPAsAGxk2+v5VG77cOHAThsXyWx-_UJ1XVeJProaa0gQWH5jvA@mail.gmail.com>
References: <1439444244-26057-1-git-send-email-ryabinin.a.a@gmail.com>
 <20150813065040.GA17983@gmail.com>
 <20150813081641.GA14402@gmail.com> <20150813090119.GA10280@arm.com>
 <CAPAsAGxk2+v5VG77cOHAThsXyWx-_UJ1XVeJProaa0gQWH5jvA@mail.gmail.com>
Message-ID: <20150813112428.GG10280@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 12:02:26PM +0100, Andrey Ryabinin wrote:
> 2015-08-13 12:01 GMT+03:00 Will Deacon <will.deacon@arm.com>:
> > Yes please, works for me! If we're targetting 4.3, then please can you base
> > on 4.2-rc4, as that's what our current arm64 queue is using?
> >
> 
> Does this mean that we are targeting arm64 part for 4.3 too?

It depends on how well it merges with our current queue and whether it
holds up to regression testing. The patches have been reviewed, so I'm
comfortable with the content, but we're not at a stage where we can debug
and fix any failures that might crop up from the merge.

Will

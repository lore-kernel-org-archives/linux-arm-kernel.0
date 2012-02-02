From: hjk@hansjkoch.de (Hans J. Koch)
Date: Thu, 2 Feb 2012 20:56:54 +0100
Subject: [PATCH 1/4] Remove Telechips ARM subarch from MAINTAINERS
In-Reply-To: <201202021346.08740.arnd@arndb.de>
References: <20111222211948.GA1201@local>
 <20120103170824.GA2914@n2100.arm.linux.org.uk>
 <20120202104541.GB1643@atrey.karlin.mff.cuni.cz>
 <201202021346.08740.arnd@arndb.de>
Message-ID: <20120202195653.GA5558@local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 01:46:08PM +0000, Arnd Bergmann wrote:
> 
> Telechips themselves seem to have given up on the ARM9 based products

That is not true. The TCC8000 is in production and available, also
derivatives like TCC8001.

The main problem is that Telechips is not interested in markets where
SoCs are sold separately. Instead, they sell complete solutions.
If you want a new DAB car radio, they'll sell you the PCB layout,
operating system, drivers, and complete software according to your
specification. They'll even organise manufacturing of the device,
and you'll get the completely working PCB in the end. You never have
to write software yourself, let alone kernel code.

That is why few people have ever heard of Telechips. Since these
SoCs are available now for everybody, it seemed a good idea to bring
that stuff to mainline.

But without ANY contribution (not even questions) from ANYBODY,
no open source project will fly.

That's why I refused to keep the Telechips subarch up-to-date
when Russell, correctly, asked me to do so. That was on the
ARM kernel mailing list, but noone shouted, hey, I'll do it!

Consequently, I removed my stuff after talking to Thomas and Harry,
who might have been still interested.

If I hadn't removed it myself, Russell would have kicked it out
sooner or later anyway. Which is the correct thing to do for code
that nobody is interested in.

Thanks,
Hans

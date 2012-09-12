From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Sep 2012 11:54:20 +0000
Subject: [PATCH v3 00/31] AArch64 Linux kernel port
In-Reply-To: <504E4C0E.9030402@jonmasters.org>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <504E4C0E.9030402@jonmasters.org>
Message-ID: <201209121154.20474.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 September 2012, Jon Masters wrote:
> On 09/07/2012 12:26 PM, Catalin Marinas wrote:
> > This is the 3rd version of patches implementing Linux kernel support for
> > the 64-bit ARM architecture.
> <snip>
> 
> > ...but the main goal was to freeze the user ABI.
> 
> Is the consensus now that we're good from an ABI viewpoint?
> 

>From my point of view, no more changes are needed. I would not give any
guarantees until we have a first kernel release including this code, but
I think we can agree that we would consult you about ABI changes if they
seem necessary before then.

If you start (re)building the Fedora packages based on these kernel
headers, the changes are pretty good that this will keep working.

	Arnd

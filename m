From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 25 Jan 2010 04:02:56 +0000
Subject: Default machine include placements
Message-ID: <20100125040255.GN26562@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently in the s3c/s5p familt we're seeing quite a number of the
same things being repeated for items like entry-macro.S, hardware.h
and so on.

The first question is about adding include/mach directories to
eitehr plat-s5p or plat-samsung to mop up the files that keep
getting repeated (since the plat-* directories are processed after
the machine directory includes the mach-xxx are still free to overide
these as necessary)

The second question is whether some of these files should have defaults
in arch/arm/include? I think this might be less useful as build failures
for new ports ensure that at-least these files are thought about

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

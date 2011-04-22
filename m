From: mikpe@it.uu.se (Mikael Pettersson)
Date: Fri, 22 Apr 2011 16:33:37 +0200
Subject: support for operating Kirkwood in big endian mode?
Message-ID: <19889.37313.25234.626786@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kirkwood docs specify that the core can be operated in both big
and little endian modes, but indicate that some peripherals in the
SoC require drivers to perform byteswapping in some case for big
endian operation.

Does the kernel support operating a Kirkwood in big endian mode?

Supposedly there's a document "AN-183" that describes the details,
but I've not been able to locate a public copy of it.

(I'd like to reuse a surplus 6281 as a build server for a big-endian
userspace I'm maintaining.  It's not a super-important project, but
a big-endian 6281 would make it viable for a bit longer.)

/Mikael

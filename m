From: mikpe@it.uu.se (Mikael Pettersson)
Date: Wed, 19 Jan 2011 21:10:58 +0100
Subject: RFC: Host-endian device tree format
In-Reply-To: <20110119121925.2680afd1@udp111988uds.am.freescale.net>
References: <AANLkTi=AdwaW5vvm1TzNxcNrjYiJ3dOEjwoZrm-koxuw@mail.gmail.com>
	<20110119121925.2680afd1@udp111988uds.am.freescale.net>
Message-ID: <19767.17746.895925.532946@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Scott Wood writes:
 > What about bi-endian hardware?  Is it possible you might ever want to
 > boot a kernel in one endianness when the device tree was generated
 > assuming the opposite choice?

There are ARMs out there, for instance IXP4XXs, that
are bi-endian, and people can and do switch endianess
when booting their kernels.

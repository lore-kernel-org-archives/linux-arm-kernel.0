From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Fri, 15 Apr 2011 16:02:31 +0200
Subject: [RFC PATCH] Consolidate SRAM support
In-Reply-To: <4DA84AAB.60601@gmail.com>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<4DA84AAB.60601@gmail.com>
Message-ID: <1302876151.2036.14.camel@team-embedded-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-04-15 at 08:39 -0500, Rob Herring wrote:
> lpc32xx and pnx4008 also use iram, but do not have an allocator (only
> 1 user). Both are doing a copy the suspend code to IRAM and run it
> which may also be a good thing to have generic code for. Several i.MX
> chips also need to run from IRAM for suspend.

There will be similar patches for my lpc2k architecture once it gets
accepted, a common interface would be _very_ beneficial IMHO.

Regards,

Ithamar.

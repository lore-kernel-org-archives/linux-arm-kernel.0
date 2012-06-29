From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jun 2012 08:50:28 +0000
Subject: [PATCH 0/3] Add ability to set defaultless network device MAC
 addresses to deterministic computed locally administered values
In-Reply-To: <20120629054404.11091.31289.stgit@build.warmcat.com>
References: <20120629054404.11091.31289.stgit@build.warmcat.com>
Message-ID: <201206290850.28541.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 June 2012, Andy Green wrote:
> The following series adds some code to generate legal, locally administered
> MAC addresses from OMAP4 CPU Die ID fuse data, and then adds an api to
> devices.c allowing board files to register device paths for network devices
> that wish to use them.
> 
> On PandaBoard / ES, two devices have no board-level MAC either assigned by
> the manufacturer or stored on the board, the last patch in the series adds
> these device paths and gets them set when the network device is registered.
> 
> The patches are against today's linux-omap.
> 

I had already provided my

Acked-by: Arnd Bergmann <arnd@arndb.de>

when we discussed this last year, and Steven also gave his

Tested-by: Steven Rostedt <rostedt@goodmis.org>

I have one comment to the second patch, which is changed slightly
from the older version.

	Arnd

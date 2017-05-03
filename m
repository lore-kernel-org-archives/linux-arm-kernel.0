From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Wed, 3 May 2017 19:38:17 +0000
Subject: [PATCH] ARM: Fix rd_size declaration
In-Reply-To: <20170503192541.GE22219@n2100.armlinux.org.uk>
References: <20170417231003.7178-1-bart.vanassche@sandisk.com>
 <1493239894.2632.15.camel@sandisk.com>
 <20170503192541.GE22219@n2100.armlinux.org.uk>
Message-ID: <1493840295.3901.32.camel@sandisk.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-05-03 at 20:25 +0100, Russell King - ARM Linux wrote:
> There were comments on the patch which seemed to be unresolved.

Do you mean the header guard? That's easy to resolve.

> However, it would be nice if rd_size could go with some other related
> declarations somewhere (if there are any.)

Sorry but I don't know about any other declarations that should be moved
into a brd header file.

Bart.

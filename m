From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 15 Mar 2018 20:20:25 +0000
Subject: [PATCH 00/60] use SPDX-License-Identifier for Kirkwood boards
In-Reply-To: <20180315165102.27160-1-gregory.clement@bootlin.com>
References: <20180315165102.27160-1-gregory.clement@bootlin.com>
Message-ID: <20180315202025.GJ17115@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Thu, Mar 15, 2018 at 05:50:02PM +0100, Gregory CLEMENT wrote:
> Hi,
> 
> this series follow the recent trend for the license description to use
> the SPDX-License-Identifier.

As there is no attempt to change any licenses at this time,

Acked-by: Jason Cooper <jason@lakedaemon.net>

> 
> The device tree for the SoCs were already converted because they
> didn't have any licenses, so they were attributed a GPLv2.0 one.
> 
> In the end for kirkwood we have:
> 
> - 89 files under GPL2.0 (including the ones that initially didn't have
>   any license)
> 
> - 8 files under GPL2.0+
> 
> - 8 files under dual license GPL2.0+/MIT (improperly called X11)
> 
> For the Armada we already switched all the file under a dual license
> GPL2.0/MIT or GPL2.0+/MIT, allowing other project to reuse the same
> device tree file. Maybe we should do the same for kirkwood, at least
> for the device tree describing the SoCs.
> 
> But I know it is not so easy because in this case we need to contact
> all the author in order to modify the license.

iirc, there was an explicit objection.  I don't recall who though.  Has
anyone from *BSD been asking for a license change, or not supporting a
board because of this?  I have a softspot for kirkwood boards, but they
are getting a bit long in the tooth...

thx,

Jason.

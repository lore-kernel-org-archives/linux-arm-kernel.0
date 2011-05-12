From: kurt.van.dijck@eia.be (Kurt Van Dijck)
Date: Thu, 12 May 2011 05:58:48 -0500
Subject: [PATCH v4 1/1] can: add pruss CAN driver.
In-Reply-To: <4DCB88A4.2010901@grandegger.com>
References: <1303474267-6344-1-git-send-email-subhasish@mistralsolutions.com>
	<2BFFDAA0A0DE4820876E5549867938EC@subhasishg>
	<201105112331.47954.arnd@arndb.de>
	<201105112344.44171.arnd@arndb.de>
	<4DCB88A4.2010901@grandegger.com>
Message-ID: <20110512105822.GA252@e-circ.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2011 at 09:13:40AM +0200, Wolfgang Grandegger wrote:
> A simple interface using:
> 
>   ip link set can0 type can filter <id>:<mask> [<id>:<mask> ...]
> 
> would just be fine.
Yep.

From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 30 Mar 2013 17:14:26 -0400
Subject: [PATCH v3 for 3.10] Introduce a Marvell EBU MBus driver
In-Reply-To: <alpine.DEB.2.02.1303302040001.13473@vroombuntu>
References: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303211730.23247.arnd@arndb.de>
 <20130321184641.GB13280@titan.lakedaemon.net>
 <CAAfodu3cfphzUPPgH7OiicnD-_YinuZZOPPStKxmOcf4uWWgpw@mail.gmail.com>
 <20130328083306.3c2a23de@skate>
 <alpine.DEB.2.02.1303282223430.28248@vroombuntu>
 <20130330202109.GU13280@titan.lakedaemon.net>
 <alpine.DEB.2.02.1303302040001.13473@vroombuntu>
Message-ID: <20130330211426.GA13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 30, 2013 at 08:41:20PM +0000, Neil Greatorex wrote:
...
> Subject: [PATCH] bus: mvebu-mbus: Restore checking for coherency fabric
>  hardware
> 
> The new mvebu-mbus driver was not checking the device tree for
> coherency fabric hardware and hence was not setting the hw_io_coherency
> flag in mbus_state. This prevented the mvsdio driver from operating
> correctly. This patch restores the check.
> 
> Signed-off-by: Neil Greatorex <neil@fatboyfat.co.uk>
> ---
>  drivers/bus/mvebu-mbus.c |    3 +++
>  1 file changed, 3 insertions(+)

Applied to mvebu/drivers

thx,

Jason.

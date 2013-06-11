From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 11 Jun 2013 12:04:43 -0400
Subject: [PATCH] ARM: Kirkwood: ts219: Enable second PCIe port in DT.
In-Reply-To: <1370955700-18111-1-git-send-email-andrew@lunn.ch>
References: <1370955700-18111-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130611160443.GS23859@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 03:01:40PM +0200, Andrew Lunn wrote:
> Enable the second PCIe port on QNAP TS-11x/TS-21x devices as newer
> revisions (rev 1.3) have a USB 3.0 chip from Etron on PCIe port 1.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/kirkwood-ts219-6282.dts |    8 ++++++++
>  1 file changed, 8 insertions(+)

Applied to mvebu/dt

thx,

Jason.

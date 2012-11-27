From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 27 Nov 2012 16:46:07 +0000
Subject: [PATCHv9 1/3] Runtime Interpreted Power Sequences
In-Reply-To: <3136860.Z3VvKjeKpU@avalon>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <6982060.HfOokt4dIn@avalon> <50B4D9E9.8070607@ti.com>
 <3136860.Z3VvKjeKpU@avalon>
Message-ID: <20121127164607.GG4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 04:37:32PM +0100, Laurent Pinchart wrote:

> One possibly crazy idea I had was to replace backlight devices as we know them 
> with LED devices (a LED driver IC shouldn't be supported by different APIs 
> depending on whether the LEDs it drives are used as a backlight or not), and 
> have the panel hook up with the associated LED device to expose backlight 
> operations through the CDF. Panels with a backlight controller tied to the 
> panel controller (control through DSI for instance) would implement the 
> backlight operations directly without instantiating a LED device. This still 
> leaves the question of the userspace backlight brightness API open.

I remember looking at that before but never actually got round to it, it
seems like a sensible idea to me.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121127/3247c778/attachment.sig>

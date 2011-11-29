From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 29 Nov 2011 18:16:09 -0500 (EST)
Subject: [patch 1/1] kirkwood: Add configuration for MPP12 as GPIO
In-Reply-To: <20111129220507.911608090@rtp-net.org>
References: <20111129220507.911608090@rtp-net.org>
Message-ID: <alpine.LFD.2.02.1111291809030.2357@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Nov 2011, Arnaud Patard wrote:

> The MPP12 is listed in the 6281 HW manual as output only but the iconnect
> board from iomega is using it as GPIO (there's a button connected on it). So,
> I'm adding a definition for the MPP12 as GPIO. As I've no informations about
> this and which kirkwood are "affected", I'm adding a new #define instead of
> modifying the current one for MPP12.

In that case, please adjust the bitfield  in your definition so it is 
valid only for 
the 6281.


Nicolas

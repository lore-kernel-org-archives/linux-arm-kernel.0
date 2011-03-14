From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 14 Mar 2011 23:14:37 +0530
Subject: [PATCH] DM644x EVM: register MUSB device earlier
In-Reply-To: <87oc5dlkkx.fsf@ti.com>
References: <201103132306.59986.sshtylyov@ru.mvista.com>
	<20110314085248.GA2285@legolas.emea.dhcp.ti.com>
	<87oc5dlkkx.fsf@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C246AD3@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2011 at 22:12:54, Hilman, Kevin wrote:
> Felipe Balbi <balbi@ti.com> writes:
> 
> [...]
> 
> >
> > Kevin feel free to take this into your tree:
> >
> > Acked-by: Felipe Balbi <balbi@ti.com>
> >
> 
> OK, will queue for 2.6.39.

This will need to make into 2.6.38.

Hi Russell,

Without this fix, USB will remain broken on 2.6.38
on DM644x EVM. Any chance of this making into 2.6.38?

Shall I check this into your patch system?

Thanks,
Sekhar

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Mar 2011 10:08:56 +0000
Subject: [PATCH] DM644x EVM: register MUSB device earlier
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C246AD3@dbde02.ent.ti.com>
References: <201103132306.59986.sshtylyov@ru.mvista.com>
	<20110314085248.GA2285@legolas.emea.dhcp.ti.com>
	<87oc5dlkkx.fsf@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C246AD3@dbde02.ent.ti.com>
Message-ID: <20110315100856.GE3921@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2011 at 11:14:37PM +0530, Nori, Sekhar wrote:
> On Mon, Mar 14, 2011 at 22:12:54, Hilman, Kevin wrote:
> > Felipe Balbi <balbi@ti.com> writes:
> > 
> > [...]
> > 
> > >
> > > Kevin feel free to take this into your tree:
> > >
> > > Acked-by: Felipe Balbi <balbi@ti.com>
> > >
> > 
> > OK, will queue for 2.6.39.
> 
> This will need to make into 2.6.38.
> 
> Hi Russell,
> 
> Without this fix, USB will remain broken on 2.6.38
> on DM644x EVM. Any chance of this making into 2.6.38?
> 
> Shall I check this into your patch system?

The answer to that is in Kevin's reply.  Kevin is handling the patch as
current maintainer of Davinci.

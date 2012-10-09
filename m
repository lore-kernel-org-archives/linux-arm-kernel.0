From: cavokz@gmail.com (Domenico Andreoli)
Date: Wed, 10 Oct 2012 01:37:43 +0200
Subject: [PATCH 6/6] ARM: bcm476x: Instantiate console UART
In-Reply-To: <507394CB.5080300@wwwdotorg.org>
References: <20121007015300.828366635@gmail.com>
 <20121007015407.840781689@gmail.com>
 <507394CB.5080300@wwwdotorg.org>
Message-ID: <20121009233743.GC7758@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 09:06:51PM -0600, Stephen Warren wrote:
> On 10/06/2012 07:53 PM, Domenico Andreoli wrote:
> > From: Domenico Andreoli <domenico.andreoli@linux.com>
> > 
> > The BCM476x sports standard PL011 UARTs which are fully described and
> > put to use with these few changes.
> 
> Given that this SoC uses an interrupt controller for which there's
> already a driver (so there's no need to wait for a later patch before
> interrupts work), and that patch 1/6 adds debug/bcm476x.S anyway, I'd be
> inclined to just squash this patch into the very first one myself.
> 
> If not, this patch isn't really just instantiating the console UART, but
> also allowing the DEBUG_LL implementation to be selected.

I created a separate patch for the DEBUG_LL and the rest is squashed in
the first infrastructure patch.

Regards,
Domenico

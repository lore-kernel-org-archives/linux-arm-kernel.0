From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Jan 2013 17:11:59 +0000
Subject: [PATCH v2 1/2] ARM: OMAP4: clock data: Lock ABE DPLL on all
 revisions
In-Reply-To: <50E6F0CA.60309@ti.com>
References: <1357294163-4317-1-git-send-email-peter.ujfalusi@ti.com>
 <1357294163-4317-2-git-send-email-peter.ujfalusi@ti.com>
 <50E6F0CA.60309@ti.com>
Message-ID: <20130104171159.GA2637@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 04, 2013 at 09:10:02AM -0600, Jon Hunter wrote:
> 
> On 01/04/2013 04:09 AM, Peter Ujfalusi wrote:
> > To avoid issues with audio caused by non locked ABE DPLL we should
> > make sure it is locked in all OMAP4 revisions.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > 
> > asda d
> 
> Not sure what the above is ;-)

And there I was, thinking it was referring to a chain of UK supermarkets. :)

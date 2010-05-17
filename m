From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 17 May 2010 11:59:55 +0200
Subject: i.MX EHCI initialization
In-Reply-To: <20100517093652.GP31199@pengutronix.de>
References: <20100517093652.GP31199@pengutronix.de>
Message-ID: <20100517095954.GQ30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, May 17, 2010 at 11:36:52AM +0200, Sascha Hauer wrote:
> I see an increasing number of patches trying to change the
> initialization sequence of the i.MX ehci controller. It's getting harder
> and harder to keep track what the changes are, what other boards
> and SoCs a single patch affects and whether it just reverts another
> patch.
> 
> I thought about making the initialization completely board specific and
> creating a set of helper functions which the board can call if it wants
> to to prevent too much code duplication.

If we really need this, I'm pro adding that kind of interface, sure.
However, at least for the MX51 stuff, altering the init order wasn't
necessary at all eventually, and I'm not sure about other SoCs.

I also didn't follow all patches in this area I fear - could you
summarize which SoC wants it differently than the current code does it?

Thanks,
Daniel

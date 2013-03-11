From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 11 Mar 2013 14:43:40 +0100
Subject: [PATCH] ARM: imx: fix typo "DEBUG_IMX50_IMX53_UART"
In-Reply-To: <20130311133720.GB25910@S2101-09.ap.freescale.net>
References: <1363007760.3137.69.camel@x61.thuisdomein>
 <20130311133720.GB25910@S2101-09.ap.freescale.net>
Message-ID: <1363009420.3137.76.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-03-11 at 21:37 +0800, Shawn Guo wrote:
> On Mon, Mar 11, 2013 at 02:16:00PM +0100, Paul Bolle wrote:
> > 1) Typo was added in commit f8c95fe6d9adad72fc7bce90f4ab68d119f50c5b
> > ("ARM: imx: support DEBUG_LL uart port selection for all i.MX SoCs").
> > Looking at that patch and at the tree makes clear that DEBUG_IMX53_UART
> > was intended here.
> 
> Thanks for the fixing.  Above comment should really be in the commit
> log.  I just applied the patch as below.

Thanks for updating the commit explanation. I guess I'll have to reserve
the "one line commit summary only" style for the really obvious typos.


Paul Bolle

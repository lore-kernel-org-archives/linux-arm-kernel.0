From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 11 Mar 2013 14:39:04 +0100
Subject: [PATCH] ARM: imx: fix typo "DEBUG_IMX50_IMX53_UART"
In-Reply-To: <513DDD59.6000903@cogentembedded.com>
References: <1363007760.3137.69.camel@x61.thuisdomein>
 <513DDD59.6000903@cogentembedded.com>
Message-ID: <1363009144.3137.72.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-03-11 at 17:34 +0400, Sergei Shtylyov wrote:
> On 11-03-2013 17:16, Paul Bolle wrote:
> > 1) Typo was added in commit f8c95fe6d9adad72fc7bce90f4ab68d119f50c5b
> > ("ARM: imx: support DEBUG_LL uart port selection for all i.MX SoCs").
> > Looking at that patch and at the tree makes clear that DEBUG_IMX53_UART
> > was intended here.
> 
>     Should probably be in the changelog instead.

I feared being to verbose. But putting it in the commit explanation is
fine with me. I'll try to send an updated patch later this day.


Paul Bolle

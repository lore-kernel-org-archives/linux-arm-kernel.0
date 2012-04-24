From: olof@lixom.net (Olof Johansson)
Date: Tue, 24 Apr 2012 14:08:47 -0700
Subject: [PATCH 3/3] ARM: dt: tegra_ventana: als and proximity sensor
 isl29018 support
In-Reply-To: <4F8DF01D.9040900@wwwdotorg.org>
References: <1334645155-13799-1-git-send-email-ldewangan@nvidia.com>
 <1334645155-13799-4-git-send-email-ldewangan@nvidia.com>
 <4F8DF01D.9040900@wwwdotorg.org>
Message-ID: <20120424210847.GA12611@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 04:35:09PM -0600, Stephen Warren wrote:
> On 04/17/2012 12:45 AM, Laxman Dewangan wrote:
> > Add the device info for ALS and proximity sensor isl29018.
> 
> (There were a ton of irrelevant people CC'd on this patch; I cut them
> out, but kept the lists in case anyone was interested in the replies.
> The most relevant list, linux-tegra, also wasn't CC'd)
> 
> > diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra-ventana.dts
> 
> > +		/* ALS and proximity sensor */
> 
> > +		isl29018: isl29018 at 44 {
> 
> I don't think the label "isl29018:" serves any purpose; nothing else
> needs to refer to this node.
> 
> I note from http://patchwork.ozlabs.org/patch/132936/ that:
> 
> a) Perhaps the vendor prefix should be "isil" not "isl". Olof, can you
> please comment here?

The standard practice is to use stock tickers, but if companies aren't public
then there isn't much you can do. Like Linus said, use your best judgement and
taste and that's really all we can ask for. :)



-Olof

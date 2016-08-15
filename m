From: andrew@aj.id.au (Andrew Jeffery)
Date: Mon, 15 Aug 2016 10:06:52 +0930
Subject: [PATCH 02/12] pinctrl: Add core pinctrl support for Aspeed SoCs
In-Reply-To: <1471049894.12231.41.camel@kernel.crashing.org>
References: <1468994313-13538-1-git-send-email-andrew@aj.id.au>
 <1468994313-13538-3-git-send-email-andrew@aj.id.au>
 <CACRpkdZ0p+jNHBV1AqhVWQ2Q8RRrHVfsAz3XU3_+f6My22=Zxg@mail.gmail.com>
 <1470962022.27272.68.camel@aj.id.au>
 <CACRpkdaN=wR4amskqMapTJzaTTMJZe2EQWRnyLMQkq_zuhr2eA@mail.gmail.com>
 <1471049894.12231.41.camel@kernel.crashing.org>
Message-ID: <1471221412.27272.76.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2016-08-13 at 10:58 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2016-08-12 at 15:18 +0200, Linus Walleij wrote:
> > 
> > I would probably prefer that option (introduce another field)
> > but you should make the overall decision, it's no strong opinion
> > from my side.
> > 
> > > 
> > > Would it be acceptable to document that requirement?
> It might make it a bit less nasty (and easier to change later on
> if necessary) to use some kind of:
> 
> 	bool ast_signal_is_gpio(...)
> 
> And stick the strcmp in there.

Yep, I'll do so for v2.

Cheers,

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160815/3268bdca/attachment.sig>

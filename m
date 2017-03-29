From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Mar 2017 14:29:58 +0200
Subject: [linux-sunxi] About the thermal sensor driver on H3/A64/H5
In-Reply-To: <20170328191855.69809125838@relay.mailchannels.net>
References: <20170328191855.69809125838@relay.mailchannels.net>
Message-ID: <20170329122958.54mgggxnztsctblg@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 03:18:43AM +0800, Icenowy Zheng wrote:
> 
> 2017?3?29? ??3:14? Vincent Legoll <vincent.legoll@gmail.com>???
> >
> > Hello,
> >
> > On Tue, Mar 28, 2017 at 6:40 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> > > I'm trying to do a mainlinable thermal driver for H3/A64/H5 SoCs;
> >
> > What's the relationship with:
> > - DVFS - from Ond?ej Jirman
> > - THS - from Josef Gajdusek
> >
> > See : http://linux-sunxi.org/Linux_mainlining_effort#Minor_drivers
> >
> > Are those not suitable ? unrelated ?
> 
> The second one is reject by Maxime.
> 
> The DVFS will come in after thermal is proper.

Not really, we can totally do DVFS without thermal support. What we
can't do is thermal throttling, which is related, but not a hard
dependency.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170329/51e1d2ee/attachment-0001.sig>

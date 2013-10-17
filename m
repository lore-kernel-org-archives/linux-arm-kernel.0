From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Oct 2013 14:32:03 +0200
Subject: sun4i_handle_irq: WARNING at net/ipv4/tcp_input.c:2711
 tcp_fastretrans_alert
In-Reply-To: <CACQ1gAinSoTCTtf9Y6TL=vtEm1jnJgis0n=y=frNtuPxue9-ng@mail.gmail.com>
References: <20130821094432.GA28249@lnx-rg> <20130823182116.GE1230@lukather>
 <CACQ1gAinSoTCTtf9Y6TL=vtEm1jnJgis0n=y=frNtuPxue9-ng@mail.gmail.com>
Message-ID: <20131017123203.GM3041@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard

On Thu, Oct 17, 2013 at 01:46:49PM +0200, Richard Genoud wrote:
> > Hmmm, that seems pretty far from the network/interrupt drivers, and it
> > looks like other users have seen this on !ARM machines:
> > http://forums.gentoo.org/viewtopic-p-7379928.html
> > https://bugzilla.redhat.com/show_bug.cgi?id=989251
> >
> > There's a patch in the redhat's bugzilla, could you try to apply it and
> > see if it solves your problem?
> >
> > Maybe the netdev guys will have other ideas as well.
> For the record, I set:
> net.ipv4.tcp_early_retrans = 2
> net.ipv4.tcp_frto = 0
> And I didn't see the warning any more.
> It's seems that a patch is on it's way. I'll try it instead of setting
> the sysctl.
> http://thread.gmane.org/gmane.linux.network/286793

Ah, I wanted to ask you about the status of this.

Thanks for the follow-up,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131017/bff5e6d3/attachment.sig>

From: ospite@studenti.unina.it (Antonio Ospite)
Date: Tue, 3 Nov 2009 21:40:20 +0100
Subject: [PATCH 0/3] ezx: A780/A910 camera, A910 leds, ezx_defconfig update
In-Reply-To: <20091103174430.GA20822@excalibur.local>
References: <1257266734-28673-1-git-send-email-ospite@studenti.unina.it>
	<20091103174430.GA20822@excalibur.local>
Message-ID: <20091103214020.a5f6bac9.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Nov 2009 18:44:30 +0100
Stefan Schmidt <stefan@datenfreihafen.org> wrote:

> Hello.
> 
> [Put Eric in CC]
>

<OT>
Thanks, I've realized that the best practice to write the summary
message is via 'git format-patch --cover-letter' to add the needed
recipients, rather than using 'git send-email --compose' which doesn't
process CCs, BCCs and SOBs for the introduction message.
</OT>

> On Tue, 2009-11-03 at 17:45, Antonio Ospite wrote:
> > 
> > some updates for the EZX platform:
> 
> Thanks for driving this forward.
> 
> > [PATCH 1/3] ezx: Add camera support for A780 and A910 EZX phones
> > [PATCH 2/3] ezx: Add leds-lp3944 support for A910 EZX phone
> > [PATCH 3/3] ezx: Update ezx_defconfig now that ezx-pcap is in
> > 
> > Are we still in time for 2.6.32?
> 
> Given that we are near -rc6 and this is clearly no fix I would say no. But Eric
> should be happy to apply it to his devel branch which will hit Linus tree during
> the next merge window.
>

That's fine, of course.

> Eric, Antonio is doing a good deal of the current work at OpenEZX. If you need
> an ACK anyway you can put mine into it.
> 
> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
> 
> regards
> Stefan Schmidt
>

Ciao,
  Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091103/63619ce5/attachment.sig>

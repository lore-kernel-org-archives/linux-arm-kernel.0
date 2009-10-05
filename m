From: dwmw2@infradead.org (David Woodhouse)
Date: Mon, 05 Oct 2009 13:24:28 +0100
Subject: Strange rejection messages -- was Your message to
	linux-arm-kernel awaits moderator approval (fwd)
In-Reply-To: <20091005120802.GB13694@elf.ucw.cz>
References: <20091004190036.GE1378@ucw.cz>
	<1254690469.3277.2467.camel@macbook.infradead.org>
	<20091004211704.GF1447@elf.ucw.cz>
	<1254724599.3277.3066.camel@macbook.infradead.org>
	<20091005115159.GD11044@shareable.org>
	<20091005120802.GB13694@elf.ucw.cz>
Message-ID: <1254745468.13096.331.camel@macbook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-10-05 at 14:08 +0200, Pavel Machek wrote:
> 
> Well, I get notified that it was trapped, but that's about it. I do
> not get notified when it is forwarded, I do not get notified _why_ it
> was trapped, and I'm not even told which exact message was that.

You do get the Subject line, although you don't get the Message-Id.

> Maybe the "trapped for moderation" message simply should not be sent,
> or only be sent after mail is in queue for 24 hours or something?

Maybe. At some point I want to turn it into an SMTP-time rejection (even
though the message is actually accepted, and the 'rejection' message
will say that. The mailman behaviour will be sending 'notification' to
people whose email address was _faked_ as the sender of the trapped
mail.

> > > This happens on lkml too, but the only difference is that you don't get
> > > _told_ about it.
> > 
> > I guess Pavel wants to know what's suspicious about it, so he can
> > avoid being stuck in the moderation queue in future.

I believe that particular message was flagged by the "Message has
References: or In-Reply-To: header, but Subject doesn't start with 'Re:'
rule -- which is there to catch the people who hijack existing threads
when they should be starting new ones.

I've now made that accept 'Re:' _anywhere_ in the subject line, rather
than only at the beginning, so I don't think that particular mail would
be trapped in future.

But the moderators are usually quite fast -- there's no real _harm_ in
being trapped for moderation. You're making a fuss over nothing.

-- 
dwmw2

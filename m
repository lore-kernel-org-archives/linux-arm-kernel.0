From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Apr 2012 13:41:05 +0100
Subject: [RFC PATCH 00/11 V5] MXS: Add i.MX28 USB Host driver
In-Reply-To: <201204251427.59194.marex@denx.de>
References: <1335099567-21056-1-git-send-email-marex@denx.de>
 <1335237523-9053-1-git-send-email-marex@denx.de>
 <20120424200215.GD3628@n2100.arm.linux.org.uk>
 <201204251427.59194.marex@denx.de>
Message-ID: <20120425124105.GX24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 02:27:58PM +0200, Marek Vasut wrote:
> Dear Russell King - ARM Linux,
> 
> > Do you really need 138 messages (and counting) all threaded together
> > across the entire history of this patch set?  Please stop posting new
> > copies of your patch set as followups to the previous set.
> 
> Well, it's usually to the point where the usb patches change, so instead of 
> posting 8 patches, I post the whole set ot make it consistent.

Sure, no problem with that.

> > Not only does it rob horizontal space for reading the subjects in the
> > index, but also it either buries your patches ages back or brings the
> > entire 138 messages to the front of mailboxes, depending on your sort
> > preferences.  Either way it makes threaded reading of the mailing list
> > really difficult.
> > 
> > Please stop this antisocial behaviour.  Thanks.
> 
> Can you please suggest better solution? You mean post each new set as a separate 
> thread ? Or post each patch as an in-reply-to previous one?

Please don't thread the posting of a new version of the patches to
the previous posting of the older version.  In other words, the
initial summary mail for V5 should not be threaded to the V4 series,
and the individual patches for V5 should only be threaded to the
initial summary mail for V5.

So, rather than this as one massive thread:
...[PATCH V3 0/N]
   +-[PATCH V3 1/N]
   | `-Replies
   +-[PATCH V3 2/N]
   | `-Replies
   +-[PATCH V3 3/N]
   | `-Replies
   `-[PATCH V4 0/N]
     +-[PATCH V4 1/N]
     | `-Replies
     +-[PATCH V4 2/N]
     | `-Replies
     +-[PATCH V4 3/N]
     | `-Replies
     `-[PATCH V5 0/N]
        +-[PATCH V5 1/N]
        | `-Replies
        +-[PATCH V5 2/N]
        | `-Replies
        `-[PATCH V5 3/N]
          `-Replies

It should be:
[PATCH V4 0/N]
+-[PATCH V4 1/N]
| `-Replies
+-[PATCH V4 2/N]
| `-Replies
`-[PATCH V4 3/N]
  `-Replies

<some time later>

[PATCH V5 0/N]
+-[PATCH V5 1/N]
| `-Replies
+-[PATCH V5 2/N]
| `-Replies
`-[PATCH V5 3/N]
  `-Replies

Where the 0/N patches have no parent message.  In other words, these
sumamry messages have no references or in-reply-to headers.

If you wish to provide a direct reference back to a previous thread,
please do so via URLs into archives, or providing the message id or
exact subject of the previous series in the new summary message body.
But please don't thread each version to the previous version!

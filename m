From: Maximilian.Schwerin@tigris.de (Maximilian Schwerin)
Date: Mon, 17 Sep 2012 15:37:08 +0200
Subject: AW: [PATCH] ARM: Add config option DEBUG_DECOMPRESS_KERNEL
In-Reply-To: <20120917131723.GB25899@glitch>
Message-ID: <5448984682E7954C9BFF27F747A9C6CA56E2F0@dolphin.TIGRIS.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Urspr?ngliche Nachricht-----
> Von: Domenico Andreoli 
> [mailto:domenico.andreoli.it at gmail.com] Im Auftrag von 
> Domenico Andreoli
> Gesendet: Montag, 17. September 2012 15:17
> An: Maximilian Schwerin
> Cc: linux-arm-kernel at lists.infradead.org
> Betreff: Re: [PATCH] ARM: Add config option DEBUG_DECOMPRESS_KERNEL
> 
> On Mon, Sep 17, 2012 at 03:08:44PM +0200, Maximilian Schwerin wrote:
> > This change allows preventing the message "Uncompressing 
> Linux..." from
> > being sent to serial port. This is necessary if the primary 
> serial port is
> > used for something other than kernel debugging (e.g. some 
> external device
> > controlled by serial commands).
> 
> Disabling CONFIG_DEBUG_LL doesn't work?
> 
> Regards,
> Domenico
> 

No (never had that enabled), but that may be a bug or omission in the platform (omap3) code?!

Regards, m.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120917/101b00c3/attachment.sig>

From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 20 Sep 2018 09:26:35 +0200
Subject: [PATCH 2/2] ARM: mvebu: Enable ARCH_WANT_LIBATA_LEDS in Armada 38x
In-Reply-To: <1537328730-9156-3-git-send-email-aditya@kobol.io>
References: <1537328730-9156-1-git-send-email-aditya@kobol.io>
 <1537328730-9156-3-git-send-email-aditya@kobol.io>
Message-ID: <20180920072635.GB20392@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-09-19 11:45:30, Aditya Prayoga wrote:
> Enable hidden symbol ARCH_WANT_LIBATA_LEDS so CONFIG_ATA_LEDS can be
> used in kernel configuration.

Should that be hidden symbol and should that be architecture specific?

For a notebook, I may want scrolllock LED to indicate ATA activity
(because I'm using USB keyboard and can't see the disk led).

Hmm. And while at it... it would be nice to have option to watch all
ATA ports combined, as well.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180920/93ca1b5b/attachment.sig>

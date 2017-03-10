From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 10 Mar 2017 14:20:50 +0100
Subject: [PATCH 1/2] ARM: dts: BCM53573: Don't use nonexistent
 "default-off" LED trigger
In-Reply-To: <42bce8ea-f1dc-2018-33f1-d296ccd7b677@gmail.com>
References: <20170308064105.26619-1-zajec5@gmail.com>
 <42bce8ea-f1dc-2018-33f1-d296ccd7b677@gmail.com>
Message-ID: <20170310132049.GC11875@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2017-03-08 09:31:44, Florian Fainelli wrote:
> On 03/07/2017 10:41 PM, Rafa? Mi?ecki wrote:
> > From: Rafa? Mi?ecki <rafal@milecki.pl>
> > 
> > Such a trigger doesn't exist in Linux and is not needed as LED is being
> > turned off by default. This could cause errors in LEDs core code when
> > trying to set default trigger.
> > 
> > Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> Since you are fixing something, what's the proper Fixes: tag for this
> commit? Likewise for the second patch.

Lets not make submitting patches any harder than it already is.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170310/1f2a84bd/attachment.sig>

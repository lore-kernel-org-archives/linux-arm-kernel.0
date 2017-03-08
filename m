From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 8 Mar 2017 11:20:59 +0100
Subject: [PATCH 1/2] ARM: dts: BCM53573: Don't use nonexistent
 "default-off" LED trigger
In-Reply-To: <20170308064105.26619-1-zajec5@gmail.com>
References: <20170308064105.26619-1-zajec5@gmail.com>
Message-ID: <20170308102058.GA7772@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2017-03-08 07:41:04, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> Such a trigger doesn't exist in Linux and is not needed as LED is being
> turned off by default. This could cause errors in LEDs core code when
> trying to set default trigger.
> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>

For both patches:

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170308/1bd05842/attachment.sig>

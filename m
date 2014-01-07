From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Jan 2014 23:49:32 +0100
Subject: [PATCH 3/5] ARM: sun5i: a13: Add missing serial aliases
In-Reply-To: <201401061347.57955.arnd@arndb.de>
References: <1388945627-3432-1-git-send-email-maxime.ripard@free-electrons.com>
 <1388945627-3432-3-git-send-email-maxime.ripard@free-electrons.com>
 <201401061347.57955.arnd@arndb.de>
Message-ID: <20140107224932.GK3103@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Jan 06, 2014 at 01:47:57PM +0100, Arnd Bergmann wrote:
> On Sunday 05 January 2014, Maxime Ripard wrote:
> > +       aliases {
> > +               serial1 = &uart1;
> > +               serial3 = &uart3;
> > +       };
> > +
> 
> If you only have two uarts active, shouldn't they be aliases
> serial0 and serial1?

Ah, yep, right.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/37d38299/attachment.sig>

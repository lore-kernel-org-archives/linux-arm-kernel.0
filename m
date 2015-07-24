From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 24 Jul 2015 10:26:53 +0200
Subject: [linux-sunxi] Re: [PATCH v2] mmc: sunxi: Don't start commands
 while the card is busy
In-Reply-To: <55AD1278.3060308@redhat.com>
References: <1436541284-11800-1-git-send-email-hdegoede@redhat.com>
 <20150720080007.GR28632@lukather> <55AD1278.3060308@redhat.com>
Message-ID: <20150724082653.GB2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 05:23:36PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 20-07-15 10:00, Maxime Ripard wrote:
> >Hi,
> >
> >On Fri, Jul 10, 2015 at 05:14:44PM +0200, Hans de Goede wrote:
> >>Some sdio wifi modules have not been working reliable with the sunxi-mmc
> >>host code. This turns out to be caused by it starting new commands while
> >>the card signals that it is still busy processing a previous command.
> >>
> >>This commit fixes this, thereby fixing the wifi reliability issues on
> >>the Cubietruck and other sunxi boards using sdio wifi.
> >>
> >>Reported-by: Eugene K <sigintmailru@gmail.com>
> >>Suggested-by: Eugene K <sigintmailru@gmail.com>
> >>Cc: Eugene K <sigintmailru@gmail.com>
> >
> >You should use the "real" name here, and not some shortening.
> 
> I don't know the real name, and AFAIK this is really only important
> for S-o-b lines.

This is mandatory only for SoB, but it's pointless to have it in the
other tags. This is to identify the developper that sets these tags,
and we can't do that without a full name.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150724/d5018f03/attachment.sig>

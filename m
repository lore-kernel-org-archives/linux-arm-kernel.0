From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 27 Jun 2013 11:43:07 +0200
Subject: [linux-sunxi] [PATCH 0/8] clocksource: sunxi: Timer fixes and
 cleanup
In-Reply-To: <51CC0566.8010302@redhat.com>
References: <1372281421-2099-1-git-send-email-maxime.ripard@free-electrons.com>
 <51CC0566.8010302@redhat.com>
Message-ID: <20130627094307.GC8437@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 11:27:02AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 06/26/2013 11:16 PM, Maxime Ripard wrote:
> >Hi everyone,
> >
> 
> <snip>
> 
> >It also finally adds a clocksource from the free running counter found in the
> >A10/A13 SoCs.
> 
> Hmm, have you benchmarked this? There have been reports from linux-sunxi kernel
> users (xbmc project) that the waiting for the latch is quite slow. Note we
> don't have anything better yet in the linux-sunxi kernel.

No. I didn't.

Do you have any pointers to these discussions?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130627/01305c94/attachment.sig>

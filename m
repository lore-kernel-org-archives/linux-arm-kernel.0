From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Feb 2011 08:17:57 -0800
Subject: [PATCH 0/8] OMAP4: hwmod data: Add a bunch of IPs
In-Reply-To: <4D5D0162.6010505@ti.com>
References: <1297938289-8678-1-git-send-email-b-cousson@ti.com>
	<20110217104207.GB17370@m-desktop> <4D5D0162.6010505@ti.com>
Message-ID: <20110217161756.GO20795@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cousson, Benoit <b-cousson@ti.com> [110217 03:05]:
> >
> >McSPI is already merged to l-o master. Will not this series breaks spi
> >hwmod?

The master branch is just a merge of the various branches, I have not
yet merged any of the hwmod touching branches into omap-for-linus.
 
> It will not break, it will just make the merge a little bit painful
> for Tony if we do not re-submit the updated McSPI hwmod data for
> OMAP4.

I'll apply Benoit's patches first, then merge or rebase the hwmod
data touching branches with that. This way following hwmod related
patches will not have merge conflicts.

Regards,

Tony

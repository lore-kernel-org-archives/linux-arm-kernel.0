From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 27 Jul 2011 21:48:45 +0530
Subject: [PATCH] DaVinci: correct MDSTAT_STATE_MASK
In-Reply-To: <201107081924.57577.sshtylyov@ru.mvista.com>
References: <201107081924.57577.sshtylyov@ru.mvista.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DDC1083@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 20:54:57, Sergei Shtylyov wrote:
> MDSTAT.STATE occupies bits 0..5 according to all available documentation, so fix
> the #define MDSTAT_STATE_MASK at last. Using the wrong value seems to have been
> harmless though...
> 
> This was noticed by me back in 2009 but I didn't follow up with the patch back
> then... :-/
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

I applied this with two changes.

Changed the headline to "ARM: davinci: correct MDSTAT_STATE_MASK"
to get the standardization requested by Arnd.

Also dropped the second paragraph of the commit text since it
doesn't really belong to the permanent history ;)

Thanks,
Sekhar

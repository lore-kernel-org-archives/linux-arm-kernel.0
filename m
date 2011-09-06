From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 6 Sep 2011 23:10:09 +0530
Subject: [PATCH] DaVinci: correct MDSTAT_STATE_MASK
In-Reply-To: <4E66251C.2020804@mvista.com>
References: <201107081924.57577.sshtylyov@ru.mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024DDC1083@dbde02.ent.ti.com>
	<4E66251C.2020804@mvista.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930257372AA8@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Tue, Sep 06, 2011 at 19:20:20, Sergei Shtylyov wrote:
> Hello.
> 
> On 07/27/2011 08:18 PM, Nori, Sekhar wrote:
> 
> >> MDSTAT.STATE occupies bits 0..5 according to all available documentation, so fix
> >> the #define MDSTAT_STATE_MASK at last. Using the wrong value seems to have been
> >> harmless though...
> 
> >> This was noticed by me back in 2009 but I didn't follow up with the patch back
> >> then... :-/
> 
> >> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
> 
> > I applied this with two changes.
> 
> > Changed the headline to "ARM: davinci: correct MDSTAT_STATE_MASK"
> > to get the standardization requested by Arnd.
> 
> > Also dropped the second paragraph of the commit text since it
> > doesn't really belong to the permanent history ;)
> 
>     You have queued it for 3.2, right?

No, actually planning to send for v3.1. Have been delayed a bit
due to my recent travel.

Thanks,
Sekhar

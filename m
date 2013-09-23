From: tj@kernel.org (Tejun Heo)
Date: Mon, 23 Sep 2013 10:12:51 -0400
Subject: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
In-Reply-To: <52404BD6.9070101@cogentembedded.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
 <1379595943-14622-9-git-send-email-rogerq@ti.com>
 <523F3567.80303@cogentembedded.com>
 <20130922214859.GC27616@mtj.dyndns.org>
 <52404BD6.9070101@cogentembedded.com>
Message-ID: <20130923141251.GB13844@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 06:10:30PM +0400, Sergei Shtylyov wrote:
> >Unless it's actually likely to cause inclusion loop, I think it's
> >better to include the header than adding explicit declarations.
> 
>    Apparently, tastes differ here. E.g. Greg KH would have also told
> Roger to use forward declaration in such case. :-)

Yes, it's a matter of taste, but, of course mine is better than
Greg's. :P

-- 
tejun

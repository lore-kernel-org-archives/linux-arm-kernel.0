From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 6 Jun 2017 16:38:27 +0200
Subject: [PATCH] net: mvpp2: do not bypass the mvpp22_port_mii_set function
In-Reply-To: <9ef70606-0918-fc4f-535b-dd1fc3475cb6@gmail.com>
References: <20170606133615.20747-1-antoine.tenart@free-electrons.com>
 <20170606154535.3e87bafb@free-electrons.com>
 <20170606135148.GA22618@kwain.lan>
 <9ef70606-0918-fc4f-535b-dd1fc3475cb6@gmail.com>
Message-ID: <20170606143827.GB22618@kwain.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On Tue, Jun 06, 2017 at 07:24:35AM -0700, Florian Fainelli wrote:
> On 06/06/2017 06:51 AM, Antoine Tenart wrote:
> > On Tue, Jun 06, 2017 at 03:45:35PM +0200, Thomas Petazzoni wrote:
> > 
> >> I am wondering if we shouldn't Cc: stable as well. I don't think we
> >> have seen issues on our side because U-Boot does the necessary
> >> initialization, but people using other bootloaders might have issues.
> > 
> > Yes, that might be safer to cc stable. I'll do this as well.
> 
> David queues network patches for stable provided that you submit those
> against his "net" tree [1] and there is an appropriate Fixes tag (which
> Thomas provided).
> 
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/netdev-FAQ.txt#n114

That's good to know!

Thanks,
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170606/282ee4c6/attachment-0001.sig>

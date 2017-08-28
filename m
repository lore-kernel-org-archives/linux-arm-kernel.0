From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 28 Aug 2017 22:03:05 +0200
Subject: [patch v1 0/2] JTAG driver introduction
In-Reply-To: <20170803174822.GI15018@lunn.ch>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
 <20170802141209.GB25781@lunn.ch>
 <AM4PR0501MB2194E6B8D14EC15356C1C0BFB1B10@AM4PR0501MB2194.eurprd05.prod.outlook.com>
 <20170803174822.GI15018@lunn.ch>
Message-ID: <20170828200305.GA5132@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Thanks a lot for review.
> > 
> 
> > We used user space tool for that, which is an adaptation of some
> > Lattice tools, which allows programming of SVF files. We are using
> > it for Lattice CPLD burning, since we have for such devices on our
> > system, but this tool could be used for programming other devices
> > from other vendors as well.
>  
> > https://github.com/mellanoxbmc/mellanox-bmc-tools
> 
> Since you are defining a new Kernel ABI here, it would be good to get
> some buy-in from potential users for the ABI. Maybe for the next
> version of the patchset you can cross post to the OpenOCD-devel list?

Actually, since you are defining a new ABI, it would be nice to have a
Documentation/ file with the ABI description, so that people can
review it...

Otherwise... yes, this looks like a step in right direction from 60000
feet above. I guess it is still a lot of work to get gdb running...

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170828/134d74ca/attachment.sig>

From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 11 Sep 2014 16:54:22 +0200
Subject: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
In-Reply-To: <1591383.Xdy91rktuP@fb07-iapwap2>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <20140911141257.GC5149@katana> <20140911144003.GD5149@katana>
 <1591383.Xdy91rktuP@fb07-iapwap2>
Message-ID: <20140911145421.GE5149@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 04:52:22PM +0200, Marc Dietrich wrote:
> Am Donnerstag, 11. September 2014, 16:40:04 schrieb Wolfram Sang:
> > > b) could be seen as a configuration thing since the functionality
> > > backend could be changed at runtime even.
> > 
> > Come to think of it, not only the functionality, also the address can be
> > changed at runtime. This makes me think it should really not be in DT
> > after all.
> 
> even worse, there can be multiple masters and slaves changing their role on 
> the fly AFAIK. So the best dt can do is to provide an initial configuration, 
> so all drivers know where they are and where to start. Everything else can be 
> changed during runtime.

Why do you want DT to be involved at all?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140911/d54e7489/attachment.sig>

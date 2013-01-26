From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 26 Jan 2013 11:03:21 +0000
Subject: [PATCH 15/19] sunrpc: don't warn for unused variable 'buf'
In-Reply-To: <201301252345.25829.arnd@arndb.de>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-16-git-send-email-arnd@arndb.de>
 <4FA345DA4F4AE44899BD2B03EEEC2FA91833C205@sacexcmbx05-prd.hq.netapp.com>
 <201301252345.25829.arnd@arndb.de>
Message-ID: <20130126110321.GE23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 11:45:25PM +0000, Arnd Bergmann wrote:
> On Friday 25 January 2013, Myklebust, Trond wrote:
> > > -----Original Message-----
> > > From: Arnd Bergmann [mailto:arnd at arndb.de]
> > > Marking it as __maybe_unused avoids a harmless gcc warning.
> > 
> > Alternatively, just declare it using the RPC_IFDEBUG() macro.
> 
> Right, makes sense: that's more consistent with other functions
> doing the same thing. Thanks for taking a look.

NAK.

There is already a fix queued up as a result of a previous report I
sent, but for some reason (which I didn't question) it was decided
not to queue it for -rc.

See Bruce's reply on lkml: 20130108212816.GA24572 at fieldses.org

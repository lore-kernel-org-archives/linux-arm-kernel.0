From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Mar 2012 09:06:40 +0000
Subject: [PATCH v2 0/9] DMA engine cookie handling cleanups
In-Reply-To: <CACRpkdYry6G4gi7LdVM4gYOQBKZCoQxdzLAGg1WcjB6rVD-PPQ@mail.gmail.com>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <CACRpkdYry6G4gi7LdVM4gYOQBKZCoQxdzLAGg1WcjB6rVD-PPQ@mail.gmail.com>
Message-ID: <20120307090640.GK17370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 09:33:49AM +0100, Linus Walleij wrote:
> On Tue, Mar 6, 2012 at 11:33 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > This patch series cleans up the handling of cookies in DMA engine drivers.
> > This is done by providing a set of inline library functions for common
> > tasks:
> 
> I just applied the latest patches right off and tested with some stressy
> MMC operations on the U300 and Ux500. (I had some minor hell
> since patch 8/9 and 9/9 were uuencoded but managed to fix it...)

That'll be some MTA deciding to change the encoding, probably because some
MTA spotted UTF-8 characters in the description and decided to convert to
base64.

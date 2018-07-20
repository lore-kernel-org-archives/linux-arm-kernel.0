From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 21 Jul 2018 00:18:10 +0200
Subject: [PATCH] i2c: davinci: Avoid zero value of CLKH
In-Reply-To: <0c29ccf5-4077-47a2-e7e0-c89ffcf8cb0b@ti.com>
References: <20180713152017.2207-1-alexander.sverdlin@nokia.com>
 <ab965f1d-de6c-75f7-9ebd-35d31ed3de18@ti.com>
 <0c29ccf5-4077-47a2-e7e0-c89ffcf8cb0b@ti.com>
Message-ID: <20180720221810.67tcrphiu5xuudam@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 01:43:46PM -0500, Grygorii Strashko wrote:
> 
> 
> On 07/17/2018 06:57 AM, Sekhar Nori wrote:
> > On Friday 13 July 2018 08:50 PM, Alexander Sverdlin wrote:
> > > If CLKH is set to 0 I2C clock is not generated at all, so avoid this value
> > > and stretch the clock in this case.
> > 
> > This must be by observation since specification does not seem to state
> > this.
> 
> It will be good to know (mention) on what hw was it observed?

Some more info would also help me to decide if this is stable material
or not. Is it a bug fix or more theoretical (but still valid, of
course)?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180721/6185618e/attachment.sig>

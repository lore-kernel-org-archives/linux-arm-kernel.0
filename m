From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 3 Jun 2017 23:25:53 +0200
Subject: [PATCH] i2c: designware: do not show SDA hold time warning when
 not needed
In-Reply-To: <20170603151821.736e6236@free-electrons.com>
References: <1492203192-28025-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1492502087.24567.47.camel@linux.intel.com>
 <20170418095939.68788787@free-electrons.com>
 <7b011e1e-8fa3-07c4-6688-5e258fd64dbd@linux.intel.com>
 <20170602201502.yobk7f7sdp34ez3d@ninjato>
 <20170603151821.736e6236@free-electrons.com>
Message-ID: <20170603212553.GA1532@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Sat, Jun 03, 2017 at 03:18:21PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Fri, 2 Jun 2017 22:15:02 +0200, Wolfram Sang wrote:
> > > hardware that doesn't support SDA hold time. But needless spamming have
> > > negative value so this is worth to fix. (I would do this as a single liner
> > > by else if ()).
> > > 
> > > Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>  
> > 
> > I agree with Jarkko on everything, including the 'else if' fix.
> 
> I am not sure to understand what Jarkko suggested to fix, besides using
> "else if" in one line. Could you be more specific about the changes you
> expect me to do?

I agree with Jarkko that needless spamming is worth fixing. Yet, it
should be done as a single line using "else if". So, basically the
paragraph I quoted from him. More clear now?

Regards,

   Wolfram
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170603/96a6744b/attachment.sig>

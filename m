From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Aug 2013 11:21:12 +0100
Subject: [PATCH v2] arm: update advice on kernel, initramfs and FDT
 load address.
In-Reply-To: <1377080188.31937.53.camel@hastur.hellion.org.uk>
References: <1375974974-31603-1-git-send-email-ian.campbell@citrix.com>
 <20130808215429.GG19383@mudshark.cambridge.arm.com>
 <1377079147.31937.37.camel@hastur.hellion.org.uk>
 <20130821100526.GK17845@n2100.arm.linux.org.uk>
 <1377080188.31937.53.camel@hastur.hellion.org.uk>
Message-ID: <20130821102112.GL17845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 11:16:28AM +0100, Ian Campbell wrote:
> On Wed, 2013-08-21 at 11:05 +0100, Russell King - ARM Linux wrote:
> > The only additional thing that needs to be added is a "Kernelversion:"
> > tag to specify which kernel version the patch was generated against.
> > That can go almost anywhere in the message before the actual patch
> > itself.
> 
> Cool. Does it understand git tags and stuff? e.g v3.11-rc3 or a sha1?

I'd prefer not full sha1's - the numeric version is normally close enough
to work out where it needs to go should it not apply immediately.

> > Alternatively, if you can remember your web login etc, then you can use
> > the online form, which tries to make it easier (since it generates the
> > formatted email for you - but some people find this method harder.)
> 
> I think remembering my web login is probably the biggest barrier for me
> there. In fact remembering the username is probably too much ;-)

Well, I've updated the email address to your current one, so you should
be able to recover the password now.

From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 25 Mar 2010 16:21:47 -0700
Subject: [GIT PULL] generic arm for MSM
In-Reply-To: <20100325225555.GL24984@n2100.arm.linux.org.uk>
References: <1269553937.21793.40.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1003251843320.694@xanadu.home>
	<1269557364.21793.52.camel@c-dwalke-linux.qualcomm.com>
	<20100325225300.GK24984@n2100.arm.linux.org.uk>
	<1269557655.21793.53.camel@c-dwalke-linux.qualcomm.com>
	<20100325225555.GL24984@n2100.arm.linux.org.uk>
Message-ID: <1269559307.21793.78.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-03-25 at 22:55 +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 25, 2010 at 03:54:15PM -0700, Daniel Walker wrote:
> > On Thu, 2010-03-25 at 22:53 +0000, Russell King - ARM Linux wrote:
> > 
> > > http://www.home.arm.linux.org.uk/developer/
> > > 
> > > has a link to gitweb for it, and a url pointing to where it is on the
> > > ftp/http site:
> > > 
> > > # rmk's GIT tree
> > > # rmk's random kernel patches and git tree 
> > > 
> > > It's not like it's hidden.
> > 
> > for that url I get,
> > 
> > Forbidden
> > You don't have permission to access /developer/ on this server.
> 
> http://www.arm.linux.org.uk/developer/
> 
> sorry, I tend to use my own local copy of the site; the public copy is
> identical.

I guess it's not hidden, but I'd say it's not easy to find .. Is there
some reason you don't want that tree in the MAINTAINERS file ?

I tried to add both,

ftp://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.git
http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.git/

and I got strange download failures ..

fatal: ftp://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.git/info/refs download error - Failed connect to ftp.arm.linux.org.uk:21; Operation now in progress

Both had the same failure. I tried with a newer git version 1.7 (before
it was 1.6) and it showed this on the ftp variant,

error: RETR response: 550 (curl_result = 78, http_code = 550, sha1 = 01e77706cdde7c0b47e5ca1f4284a795504c7c40The command seems to be hund

However, it did finish downloading the tree ..

Are these known issues, or maybe it's because bits are traveling
US<->UK ?

Daniel

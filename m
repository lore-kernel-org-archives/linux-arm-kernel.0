From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 01 Apr 2010 16:11:31 -0700
Subject: [GIT PULL] generic arm for MSM
In-Reply-To: <20100326082300.GA6665@n2100.arm.linux.org.uk>
References: <1269553937.21793.40.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1003251843320.694@xanadu.home>
	<1269557364.21793.52.camel@c-dwalke-linux.qualcomm.com>
	<20100325225300.GK24984@n2100.arm.linux.org.uk>
	<1269557655.21793.53.camel@c-dwalke-linux.qualcomm.com>
	<20100325225555.GL24984@n2100.arm.linux.org.uk>
	<1269559307.21793.78.camel@c-dwalke-linux.qualcomm.com>
	<20100326081445.GB20553@pengutronix.de>
	<20100326082300.GA6665@n2100.arm.linux.org.uk>
Message-ID: <1270163491.16695.27.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-03-26 at 08:23 +0000, Russell King - ARM Linux wrote:
> On Fri, Mar 26, 2010 at 09:14:45AM +0100, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > > I tried to add both,
> > > 
> > > ftp://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.git
> > > http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.git/
> > > 
> > > and I got strange download failures ..
> > It's recommended to have an actual copy of Linus' tree to fetch Russells
> > into.  Then it works fine most of the time.
> 
> There shouldn't be any problem; that tree is an identical copy of my
> local tree which uses no alternatives.  It always contains an entire
> set of Linus' tree with no additional repacking.

Now I'm getting this when I try to fetch your tree,

error: RETR response: 550 (curl_result = 78, http_code = 550, sha1 = 2725898fc9bb2121ac0fb1b5e4faf4fc09014729)
error: RETR response: 550 (curl_result = 78, http_code = 550, sha1 = b72c40949b0f04728f2993a1434598d3bad094ea)
error: RETR response: 550 (curl_result = 78, http_code = 550, sha1 = 2eaa9cfdf33b8d7fb7aff27792192e0019ae8fc6)
error: RETR response: 550 (curl_result = 78, http_code = 550, sha1 = e4d50423d773fb8d5b714430ba5358e8a1b87c14)
error: RETR response: 550 (curl_result = 78, http_code = 550, sha1 = 162451fe66ce653aba0882a73c91b18006263397)
error: RETR response: 550 (curl_result = 78, http_code = 550, sha1 = 698a60b84f0ea4fe4a35aaeeb554e2e364adbb3c)
error: RETR response: 550 (curl_result = 78, http_code = 550, sha1 = 31bd585167b1da44dbb0242c1e1c3bef8126f7a2)
error: RETR response: 550 (curl_result = 78, http_code = 550, sha1 = 6d7959089feef578b898c72ca7d5397114262a6d)
error: FTP response timeout (curl_result = 28, http_code = 150, sha1 = 0f59db814fb8d112ea3ded5ca240aaf7e9b165dd)
error: Unable to find 9dc95cddf0db231f714b583d41872f5682c7fa10 under ftp://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.git
Cannot obtain needed tree 9dc95cddf0db231f714b583d41872f5682c7fa10
while processing commit 7998a8787a8b35fede689c2bb716f65b231e7492.
error: Fetch failed.

Ultimately the fetch fails .. I did this on multiple git trees with the
same result ..

Daniel

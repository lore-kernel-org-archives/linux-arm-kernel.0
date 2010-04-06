From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 6 Apr 2010 17:34:16 -0500
Subject: [GIT PULL] generic arm for MSM
In-Reply-To: <1270591732.9066.54.camel@c-dwalke-linux.qualcomm.com>
References: <1269557364.21793.52.camel@c-dwalke-linux.qualcomm.com>
	<20100325225300.GK24984@n2100.arm.linux.org.uk>
	<1269557655.21793.53.camel@c-dwalke-linux.qualcomm.com>
	<20100325225555.GL24984@n2100.arm.linux.org.uk>
	<1269559307.21793.78.camel@c-dwalke-linux.qualcomm.com>
	<20100326081445.GB20553@pengutronix.de>
	<20100326082300.GA6665@n2100.arm.linux.org.uk>
	<1270163491.16695.27.camel@c-dwalke-linux.qualcomm.com>
	<20100406213532.GC12831@n2100.arm.linux.org.uk>
	<1270591225.9066.52.camel@c-dwalke-linux.qualcomm.com>
	<20100406220418.GD12831@n2100.arm.linux.org.uk>
	<1270591732.9066.54.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <0D753D10438DA54287A00B0270842697636D1FD94C@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 06, 2010 3:09 PM, Daniel Walker wrote:
> On Tue, 2010-04-06 at 23:04 +0100, Russell King - ARM Linux wrote:
>>  
>>> Does you server list anything wrong happening, cause those 550 errors
>>> seem pretty suspect. It could also be some sort of firewall thing on my
>>> end. I'm assuming no one else has reported anything like this before
>>> right?
>> 
>> The 550 errors are because the unpacked objects don't exist; they're
>> already inside one of Linus' pack files which you should already have.
>> 
>> That's the point - you should already have these git IDs (the ones you
>> explicitly refer to) so there should be no reason for git to even
>> consider fetching them via http or ftp.
>
> So your saying that the git defect .. I'm using a fairly recent version
> of git 1.7.0 .. There are slightly more recent ones which I can try
> also.

Daniel,

I just updated my copy of Russell's tree with no issues:

 $ git remote update
Fetching origin
Fetching linux-arm

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 25 Mar 2012 14:35:06 +0100
Subject: [PATCH v8 RESEND] ARM: net: JIT compiler for packet filters
In-Reply-To: <4F6F19C2.60602@gmail.com>
References: <1331933316-10197-1-git-send-email-mgherzan@gmail.com>
 <20120319.172005.1889334604020296555.davem@davemloft.net>
 <4F6EEAB5.7070009@gmail.com> <20120325095711.GC5611@n2100.arm.linux.org.uk>
 <4F6F19C2.60602@gmail.com>
Message-ID: <20120325133506.GG5611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 25, 2012 at 03:12:34PM +0200, Mircea Gherzan wrote:
> Am 25.03.2012 11:57, schrieb Russell King - ARM Linux:
> > On Sun, Mar 25, 2012 at 11:51:49AM +0200, Mircea Gherzan wrote:
> >> Am 19.03.2012 22:20, schrieb David Miller:
> >>> I would like to see this merged however is feasible, this has been in
> >>> a catatonic state for two releases and waiting longer isn't going to
> >>> improve things enough to justify any further delay.
> >>
> >> It has been merged into the ARM tree more than a week ago, but
> >> unfortunately it seems it will not make it into 3.4.
> > 
> > Why do you say that?
> 
> The patch is nowhere to be found in any of the branches of your
> linaro.org tree, the tree from which Linus pulls.

I only push stuff out there just before asking Linus to pull.  The main
tree is on zeniv aka ftp.arm.linux.org.uk as detailed on my website which
does contain your patch - and its this tree with linux-next fetches.

As Linus is away on an extended weekend, don't expect to see many more
pushes from me before Monday/Tuesday.

But, rest assured, I _am_ intending sending it for this merge window.

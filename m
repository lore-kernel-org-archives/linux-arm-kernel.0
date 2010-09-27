From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 27 Sep 2010 01:17:01 +0100
Subject: [RESEND PATCH] serial: samsung: fix device name
In-Reply-To: <20100924073453.GA3840@richter>
References: <20100923190212.18863.25678.stgit@darius-desktop>	<4C9BE577.4050504@fluff.org>	<AANLkTi=S8v19iT1DC=6Nh9BEgRvKzyzKTKoJmS0Bw1Fb@mail.gmail.com>
	<20100924073453.GA3840@richter>
Message-ID: <4C9FE27D.80407@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/09/10 08:34, Simon Richter wrote:
> Hi,
> 
> On Fri, Sep 24, 2010 at 09:57:19AM +0300, Darius Augulis wrote:
> 
>> It does - now devices are named /dev/s3c2410_serial, and patch changes
>> its name to /dev/ttySAC
> 
> I wonder if it'd make sense to name them ttyS[0-9]. I've never
> understood why the platform standard fixed serial ports on any device
> should have a different name.

Different driver. And yes, we've built systems with both this and
an 8250 base chip.

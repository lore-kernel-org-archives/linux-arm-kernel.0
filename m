From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Apr 2010 18:41:57 +0100
Subject: AACI broken with commit 29a4f2d3
In-Reply-To: <s5hfx39dmp2.wl%tiwai@suse.de>
References: <1269608410.807.23.camel@e102109-lin.cambridge.arm.com>
	<4BACB256.3020404@mvista.com>
	<1269611685.807.55.camel@e102109-lin.cambridge.arm.com>
	<20100326140833.GK27692@sirena.org.uk>
	<1269612734.807.73.camel@e102109-lin.cambridge.arm.com>
	<1269619671.30296.1.camel@localhost.localdomain>
	<s5heij66b5o.wl%tiwai@suse.de> <4BB05A92.7010607@mvista.com>
	<s5h4ojz4l16.wl%tiwai@suse.de> <s5hfx39dmp2.wl%tiwai@suse.de>
Message-ID: <20100406174157.GB12831@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 06, 2010 at 10:12:09AM +0200, Takashi Iwai wrote:
> This issue is still pending.
> Can anyone give a proper patch with a rational explanation?
> 
> Philby's last patch looks OK to apply wrt coding (at least better than
> the original one), but it doesn't clarify exactly why.

It is technically *incorrect*, which is why I NAK'd it - several times.

I don't know how we can proceed on this; we certainly can not go adding
this positively incorrect change to the kernel.

Maybe Philby would like to take the time to understand the technical
objection to his patch(es), and try to work out a more reasonable
solution.  Short of that, there doesn't appear to be any other way to
proceed - and given that I suggest that we put the issue on the back
burner until someone who is willing to investigate _can_ and is willing
to do so.

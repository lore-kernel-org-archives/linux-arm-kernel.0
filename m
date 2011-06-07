From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Jun 2011 23:36:14 +0100
Subject: [PATCH] ARM:SAMSUNG: Move S3C DMA driver to drivers/dma
In-Reply-To: <BANLkTikLFCyzU3UApjjwfX0Vjujo9WAFZA@mail.gmail.com>
References: <1307432901-22781-1-git-send-email-alim.akhtar@samsung.com>
	<BANLkTintADbXSiV07VTMbFfmUV+4-q2-gw@mail.gmail.com>
	<BANLkTimjWNf3PxHXj3o5qubH5g7gMHjhFg@mail.gmail.com>
	<20110607081527.GB20929@n2100.arm.linux.org.uk>
	<BANLkTin66PhYGmVSOJcuZr8wDH_iNgjhZQ@mail.gmail.com>
	<20110607182923.GA28451@n2100.arm.linux.org.uk>
	<BANLkTikLFCyzU3UApjjwfX0Vjujo9WAFZA@mail.gmail.com>
Message-ID: <20110607223614.GC28451@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2011 at 01:16:40AM +0530, Jassi Brar wrote:
> IMHO Samsung SoC team (not his majesty Mr Kyungmin Park) are justified
> if they are not so eager right now. Since I no more would have to spend
> sleepless nights over
> SPDIF underruns, I can side with what Kukjin Kim(Samsung maintainer)
> decides, who has to live with the results.

Well, the question is _when_ will these things happen in the Samsung
world?

I see no effort from the Samsung folk to even start considering moving
to common APIs - I see precisely the opposite.  They seem to have a
strong desire to invent their own new APIs all the time rather than
look at existing APIs and discuss how they can be used or adapted so
they work for Samsung.

That is not sustainable, and if it continues, it will probably result
in Samsung stuff being chucked out of mainline.  We are most definitely
at the point where custom APIs are no longer permissible, especially
for any new SoCs.

From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 22 Jul 2010 14:23:52 +0200
Subject: ARM Kernel autobuilder
In-Reply-To: <20100722111412.GB10399@kyllikki.org> (Vincent Sanders's message
	of "Thu\, 22 Jul 2010 12\:14\:12 +0100")
References: <20100722111412.GB10399@kyllikki.org>
Message-ID: <87iq47k8mf.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vincent Sanders <vince@simtec.co.uk> writes:

Hi,

> A short note to apologize to the kirkwood people over the autobuilder
> producing junk results for their defconfig on the last few builds. The
> ccache got corrupted due to a disk glitch. All fixed now.

Thanks a lot for fixing that (I was really wondering what was the issue
as I couldn't reproduce it here) and thanks even more for all the work
you've done on the kautobuild stuff.

[...]

> Finally the n8x0 and ns9xxx configurations have failed to build for a
> while now.
>
> The n8x0 config supports machines maintained by Kai Svahn, Lauri
> Leukkunen and Timo O. Karjalainen can one of you please fix the build?

It has been discussed on the linux-omap mailing list :
http://marc.info/?l=linux-omap&m=127832134917694&w=2

Don't know the status of the patch though.

Arnaud

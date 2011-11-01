From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Nov 2011 18:05:06 +0000
Subject: [PATCH 01/51] ARM: reset: introduce arm_arch_reset function
	pointer
In-Reply-To: <20111031120603.GJ19187@n2100.arm.linux.org.uk>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-2-git-send-email-will.deacon@arm.com>
	<20111029102108.GY19187@n2100.arm.linux.org.uk>
	<20111029135653.GA25057@mudshark.cambridge.arm.com>
	<20111031120603.GJ19187@n2100.arm.linux.org.uk>
Message-ID: <20111101180506.GD15232@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Oct 31, 2011 at 12:06:03PM +0000, Russell King - ARM Linux wrote:
> On Sat, Oct 29, 2011 at 02:56:53PM +0100, Will Deacon wrote:
> > Yup, it's a fantastic idea because it allows us to put all of the identity
> > mapping bits into setup_restart as well. So then platforms make the choice
> > about the mapping they want, rather than being told via the reboot mode.
> 
> I've now committed my patch, so if you'd like to give it an acked by,
> and preferably a tested-by, I'll publish it out in a stable branch.

Did you push this out to a stable branch? I should get time to look at this
tomorrow so it would be great to use your stuff as a base.

Appreciate you've been stuck with Coccinelle, for which I'm partly to blame!

Will

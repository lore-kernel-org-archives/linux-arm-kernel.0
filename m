From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Wed, 7 Oct 2009 18:33:51 +0400
Subject: RMK's sa1100 branch (was Re: [PATCH 2/9] collie: prepare for
	gpiolib use)
In-Reply-To: <20091007131003.GA11371@n2100.arm.linux.org.uk>
References: <1254778533-3529-1-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-2-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-3-git-send-email-thommycheck@gmx.de>
	<20091007110805.GA7656@rainbow>
	<20091007112552.GC6246@n2100.arm.linux.org.uk>
	<20091007124251.GB7656@rainbow>
	<20091007131003.GA11371@n2100.arm.linux.org.uk>
Message-ID: <20091007143351.GA10769@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:10 Wed 07 Oct     , Russell King - ARM Linux wrote:
> On Wed, Oct 07, 2009 at 04:42:52PM +0400, Dmitry Artamonow wrote:
> I tinkered around with this yesterday before your message came through,
> and I defined a new set of definitions, eg:
> 
> #define H3100_GPIO_IR_ON	8
> 
> so avoiding the problem.  See my 'sa1100' branch published in the usual
> places.

Whoa! Seems that you did a lot of work. What do you plan to do with it?
Should I rebase my work on top of IPAQ patches in this branch? Basically
they do the same as my patches, but there's some things here and there
that I missed or not done yet, and will gladly reuse.

-- 
Best regards,
Dmitry "MAD" Artamonow

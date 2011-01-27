From: cjb@laptop.org (Chris Ball)
Date: Thu, 27 Jan 2011 15:33:32 +0000
Subject: [PATCH] MMCI: don't read command response when invalid
In-Reply-To: <20110127121901.GB25968@n2100.arm.linux.org.uk>
References: <20110111163502.GJ11039@n2100.arm.linux.org.uk>
	<20110111163556.GA18746@n2100.arm.linux.org.uk>
	<20110111232025.GA25752@void.printf.net>
	<20110127121901.GB25968@n2100.arm.linux.org.uk>
Message-ID: <20110127153332.GA14591@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Jan 27, 2011 at 12:19:01PM +0000, Russell King - ARM Linux wrote:
> FYI, I've now merged this into the ARM devel tree for the time being so
> it doesn't get forgotten - which means it'll appear in linux-next at some
> point if it isn't already there.  (Mainly so I don't have to keep on
> adding the patch.)
> 
> Once you push it into mainline, I'll drop my copy.

Okay.  Sent this to Linus yesterday, just waiting for him to pull.
(It's been in linux-next for the last two weeks.)

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Feb 2014 10:06:49 +0000
Subject: [PATCH] ARM: enable IRQs in user undefined instruction vector
In-Reply-To: <CAOaiJ-kY_VwsY0iHSMVQZx=zvP5is1LRkir5_zP6Jnttv+O1VQ@mail.gmail.com>
References: <1391545146-8320-1-git-send-email-kevin@bracey.fi>
 <20140206112039.GA31054@arm.com> <52F3D024.5020804@bracey.fi>
 <20140206205447.GX26684@n2100.arm.linux.org.uk>
 <CAOaiJ-kY_VwsY0iHSMVQZx=zvP5is1LRkir5_zP6Jnttv+O1VQ@mail.gmail.com>
Message-ID: <20140207100649.GZ26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 03:30:13PM +0530, vinayak menon wrote:
> Can we do something similar to what pagefault_disable does ? So that
> we jump directly to fixup, after the in_atomic() check in
> do_page_fault.

I don't see any point to this change - it does nothing to address the
point I raised.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".

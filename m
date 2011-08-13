From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 13 Aug 2011 15:45:25 +0100
Subject: [PATCH] Fix non-LPAE boot regression.
In-Reply-To: <20110813143903.GQ4775@n2100.arm.linux.org.uk>
References: <201108131556.27301.anarsoul@gmail.com>
	<1313240299-24712-1-git-send-email-anarsoul@gmail.com>
	<CAHkRjk4p1kqwKGiW_XRFU0aap98QkvRGRs0hwsBR4CcfM5RKqA@mail.gmail.com>
	<20110813143903.GQ4775@n2100.arm.linux.org.uk>
Message-ID: <CAHkRjk5aK7kkfpCoTqtwgkM8hjJx5MfD-Z7stXmqyWSz4VE56g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, 13 August 2011, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Aug 13, 2011 at 03:14:30PM +0100, Catalin Marinas wrote:
>> Thanks for this. The original code was indeed broken but I think the
>> fix should be to use SECTION_SIZE instead of SHIFT. I'll have a look
>> on Monday.
>
> No, the original code is not broken. ?Look at what it's doing:

I meant my original LPAE code (though strangely it was booting fine, I
guess it didn't use more than a section from those mappings). I'll
look at the details on Monday, I'm away from my PC now.

-- 
Catalin

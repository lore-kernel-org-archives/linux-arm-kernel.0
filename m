From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Jul 2011 00:34:45 -0700
Subject: [PATCH] ARM: OMAP4: PCM049: remove vusim regulator
In-Reply-To: <1310561772.18446.14.camel@lws-weitzel>
References: <1310554738.18446.12.camel@lws-weitzel>
	<1310554762-10743-1-git-send-email-j.weitzel@phytec.de>
	<4E1D8BCD.5060901@ru.mvista.com>
	<1310561772.18446.14.camel@lws-weitzel>
Message-ID: <20110714073445.GL5783@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jan Weitzel <J.Weitzel@phytec.de> [110713 05:51]:
> Am Mittwoch, den 13.07.2011, 16:13 +0400 schrieb Sergei Shtylyov:
> 
> > 
> >     Have you added that 'i' at the end intentionally?
> > 
> Thank you. It was a tribute to vim.

:i)

I'll fold the fixed patch into your original patch. Will also
keep the new board files in testing-board because of the code
coalescing and device tree conversion effort.

Tony

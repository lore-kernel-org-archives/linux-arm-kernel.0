From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Tue, 17 May 2011 08:26:44 +0400
Subject: [alsa-devel] [PATCH v2 1/3] ASoC: Asahi Kasei AK4641 codec driver
In-Reply-To: <20110516212533.GA2570@sirena.org.uk>
References: <1305579805-15617-1-git-send-email-mad_soft@inbox.ru>
	<1305579805-15617-2-git-send-email-mad_soft@inbox.ru>
	<20110516212533.GA2570@sirena.org.uk>
Message-ID: <20110517042644.GA19254@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:25 Mon 16 May     , Mark Brown wrote:
> On Tue, May 17, 2011 at 01:03:23AM +0400, Dmitry Artamonow wrote:
> > A driver for the AK4641 codec used in iPAQ hx4700 and Glofiish M800
> > among others.
> 
> This looks pretty good - a few small issues realting to the use of old
> APIs and coding standards below but nothing serious.
> 

Hi, Mark! Thanks for review - your comments are really valuable.
It seems that ASoC APIs change faster than I adapt this driver to them, but
I hope that preparing v3 will take less time than v1->v2 took :)

-- 
Best regards,
Dmitry "MAD" Artamonow

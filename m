From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 22 Aug 2011 18:43:25 +0200
Subject: [PATCH] ARM: mx27: Print silicon revision on boot
In-Reply-To: <CAOMZO5BLpSKROCpo0N293VtqpE4RigwPnXmW6HHCt1skNHRZGg@mail.gmail.com>
References: <1314028361-25622-1-git-send-email-fabio.estevam@freescale.com>
	<201108221805.58180.marek.vasut@gmail.com>
	<CAOMZO5BLpSKROCpo0N293VtqpE4RigwPnXmW6HHCt1skNHRZGg@mail.gmail.com>
Message-ID: <201108221843.25560.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 22, 2011 06:10:46 PM Fabio Estevam wrote:
> On Mon, Aug 22, 2011 at 1:05 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> ...
> 
> > I didn't check really, but can't you just do some kind of a numeric
> > transformation instead of storing strings ?
> 
> I am using the same approach used by other i.MX processors.

Hi,

does that mean it's "obviously correct (TM)" ? To do it differently can sometimes 
introduce smarted solution etc etc. Taking a quick look, it shouldn't be difficult 
even.

Cheers
> 
> Regards,
> 
> Fabio Estevam

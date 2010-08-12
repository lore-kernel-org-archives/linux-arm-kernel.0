From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 12 Aug 2010 13:04:00 +0200
Subject: [PATCH 1/2 v2] ARM: Fix gen_nand probe structures contents
In-Reply-To: <AANLkTimuLjGo7O1kWXq0XbTns4EV2e5q5o0esNns1BY9@mail.gmail.com>
References: <1281581635-26213-1-git-send-email-marek.vasut@gmail.com>
	<AANLkTimuLjGo7O1kWXq0XbTns4EV2e5q5o0esNns1BY9@mail.gmail.com>
Message-ID: <201008121304.01178.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 12. srpna 2010 05:36:31 Mike Frysinger napsal(a):
> On Wed, Aug 11, 2010 at 22:53, Marek Vasut wrote:
> > These three platforms didn't properly fill nr_chips in gen_nand
> > registration and
> 
> > therefore depended on gen_nand bug fixed by the following patch:
> the Blackfin arch has a mailing list ... no need to pick out people

Hi, that's true, but there's that "scripts/get_maintainer.pl" thing which gave 
me this list.

Cheers
> 
> > "mtd: gen_nand: fix support for multiple chips"
> > 
> >  arch/blackfin/mach-bf537/boards/stamp.c   |    1 +
> >  arch/blackfin/mach-bf561/boards/acvilon.c |    1 +
> 
> looks sane enough to me
> Acked-by: Mike Frysinger <vapier@gentoo.org>
> -mike

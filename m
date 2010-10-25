From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 25 Oct 2010 11:35:22 +0100
Subject: [RFC PATCH 09/18] ARM: LPAE: Add fault handling support
In-Reply-To: <20101025101711.GA32026@shutemov.name>
References: <20101025085812.25275.55757.stgit@e102109-lin.cambridge.arm.com>
	<20101025090024.25275.59418.stgit@e102109-lin.cambridge.arm.com>
	<20101025101711.GA32026@shutemov.name>
Message-ID: <1288002922.14756.10.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-10-25 at 11:17 +0100, Kirill A. Shutemov wrote:
> On Mon, Oct 25, 2010 at 10:00:24AM +0100, Catalin Marinas wrote:
> > +     { do_bad,               SIGILL,  BUS_ADRALN,    "alignment fault"               },
> 
> s/SIGILL/SIGBUS/

Good point, thanks.

Catalin

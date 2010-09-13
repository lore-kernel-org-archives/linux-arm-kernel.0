From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 13 Sep 2010 14:42:26 +0200
Subject: [PATCH v2] AT91: Add flexibity board support
In-Reply-To: <AANLkTikotyfyvJ76-kemy_NPGEJifEF8PcuWuiomuc_2@mail.gmail.com>
References: <4C8DFA84.4040501@gmail.com>
	<201009131256.36523.marek.vasut@gmail.com>
	<AANLkTikotyfyvJ76-kemy_NPGEJifEF8PcuWuiomuc_2@mail.gmail.com>
Message-ID: <201009131442.26618.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 13. z??? 2010 13:02:24 Maxim Osipov napsal(a):
> Hi!
> 
> On Mon, Sep 13, 2010 at 2:56 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > Dne Po 13. z??? 2010 12:18:44 Maxim Osipov napsal(a):
> > 
> > btw. don't you want to modularize this code a bit ? check how
> > mach-pxa/z2.c or mach-pxa/vpac270.c is done for example.
> 
> No, all functionality is needed in the product, so I do not think
> modularization is necessary.
> 
> Kind regards,
> Maxim

Ok, please fix the include then

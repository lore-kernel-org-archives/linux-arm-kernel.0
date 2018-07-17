From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Tue, 17 Jul 2018 23:05:23 +0200
Subject: [PATCH 2/3] mtd: atmel nand: fix build warning on 64-bit
In-Reply-To: <CAK8P3a3NbrRVC-7HW8NiNQw+E3n_-r746AFTc2dftagTYLYDtw@mail.gmail.com>
References: <20180709155730.2422841-1-arnd@arndb.de>
 <20180709155730.2422841-2-arnd@arndb.de>
 <0b4ee469-8c37-9002-9067-f37f8dde869e@microchip.com>
 <CAK8P3a3NbrRVC-7HW8NiNQw+E3n_-r746AFTc2dftagTYLYDtw@mail.gmail.com>
Message-ID: <20180717230523.7005ca91@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> wrote on Fri, 13 Jul 2018 12:16:09 +0200:

> On Fri, Jul 13, 2018 at 11:56 AM, Tudor Ambarus
> <tudor.ambarus@microchip.com> wrote:
> > Hi, Arnd,
> >
> > On 07/09/2018 06:57 PM, Arnd Bergmann wrote:  
> >> +     nc->ebi_csa_offs = (uintptr_t)match->data;  
> >
> > I guess we should declare ebi_csa_offs as size_t, right?  
> 
> Yes, that would make sense, though it doesn't change the behavior.
> 

Do you plan to send a new version? I don't want to mess with
improvised casts :)

Thanks,
Miqu?l

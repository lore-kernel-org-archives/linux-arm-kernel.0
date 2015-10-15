From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 21:34:51 +0200
Subject: [PATCH v1 1/2] phy: keystone: serdes driver for gbe 10gbe and pcie
In-Reply-To: <561FCDC0.3080109@ti.com>
References: <1444919145-30845-1-git-send-email-w-kwok2@ti.com>
 <5192855.p6QLDWTiVi@wuerfel> <561FCDC0.3080109@ti.com>
Message-ID: <6215485.RTPqreMEMX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 October 2015 12:01:04 Murali Karicheri wrote:
> 
> >> + * Redistributions in binary form must reproduce the above copyright
> >> + * notice, this list of conditions and the following disclaimer in the
> >> + * documentation and/or other materials provided with the
> >> + * distribution.
> >
> > The current code does not do this when compiled, which might be a
> > problem for distributors. Can you clarify the license?
> >
> Arnd,
> 
> Can you elaborate on this? I did a grep on the string "Redistributions 
> in binary form must reproduce the above copyright" and I could find 
> several instance of this. So I am not sure what you mean by "The current 
> code does not do this when compiled".

You write that the binary form of the code must produce the copyright
notice. I don't see any code that does this. If I was looking in the
wrong place, let me know.

	Arnd

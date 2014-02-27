From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Feb 2014 08:30:16 +0100
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <20140226222147.GE16149@cbox>
References: <20140226183454.GA14639@cbox>
 <CABGGisxHOVqLcG7hVAuAzdeic41KWSLLBSjQLSJQcjTXLhNCow@mail.gmail.com>
 <20140226222147.GE16149@cbox>
Message-ID: <201402270830.16903.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 February 2014, Christoffer Dall wrote:
> Personally I'm all for simplicity so I don't want to push any agenda for
> ACPI in VMs.
> 
> Note that the spec does not mandate the use of ACPI, it just tells you
> how to do it if you wish to.
> 
> But, we can change the spec to require full FDT description of the
> system, unless of course some of the ACPI-in-VM supporters manage to
> convince the rest.

I guess the real question is whether we are interested in running Windows RT
in VM guests. I don't personally expect MS to come out with a port for
this spec, no matter what we do, but some of you may have information I don't.

	Arnd

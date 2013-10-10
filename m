From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 10 Oct 2013 11:44:44 -0300
Subject: [PATCH v2 1/4] clk: mvebu: Add Core Divider clock
In-Reply-To: <CAFJTrDtxt7M77W_DMMUhWAMUFDL7-N3oktKvd0mixaS9yOvaBg@mail.gmail.com>
References: <CAFJTrDtxt7M77W_DMMUhWAMUFDL7-N3oktKvd0mixaS9yOvaBg@mail.gmail.com>
Message-ID: <20131010144443.GA2558@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mattew:

On Thu, Oct 10, 2013 at 03:04:29PM +0100, Matthew Minter wrote:
> 
> I noticed this patch set and mention to developing a nand driver for
> this chip. I am involved in the work with a board based around it and
> lack of current nand support with its controller is a problem. Is
> there any way I could help with the nand driver development if any has
> started?
> 

Sure. You can start by taking a look at the first series I sent
to linux-mtd mailing list:

http://lwn.net/Articles/567884/

And test them or provide some feedback and comments. We can certainly
use some more eyes looking at the code!

> (I do have some experience in kernel driver development so if there
> are any known issues or known incomplete drivers I would be happy to
> take a look, else I would like to know any other way I could support
> here)
> 

I'm currently working on this, so you can expect a v2 patchset soon.
If you can comment and/or test the patches as they arrive, that would be
great help.

Of course, keep in mind this work-in-progress so be extra-careful where
you use this driver.

Thanks!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

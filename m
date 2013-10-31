From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 31 Oct 2013 14:22:33 -0400
Subject: [PATCH v2 00/27] Armada 370/XP NAND support
In-Reply-To: <20131031155808.GB2468@localhost>
References: <1382137374-21251-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131031155808.GB2468@localhost>
Message-ID: <CAN8TOE-XdPgHykzzJtpkQ3ApTLXjZ+hCiAPpOBCZqa7uVt=kcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 12:58:09PM -0300, Ezequiel Garcia wrote:
> Can we start discussing this patchset?
> I realize is a big series, but better starting sooner than later! :)

Yeah, I'm still figuring out prioritization here. I got a little
side-tracked on a few other patch series, some of which had
dependencies on each other. I will take a look at yours next.

...

> >   mtd: nand: pxa3xx: Introduce multiple page I/O support
> ^^^
> .. this one seems to me like the most conflicting patches as
> they extend the ECC, adding BCH. Could you review them and
> provide any comments?

Sure thing.

Brian

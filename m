From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 30 Jan 2013 16:02:05 +0530
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <201301301008.31196.arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <201301300941.35886.arnd@arndb.de>
 <CAOh2x==WZePgfTWwL0vPdE693n44vW05OS=DSqbnDCs2xzHXuw@mail.gmail.com>
 <201301301008.31196.arnd@arndb.de>
Message-ID: <CAKohpomdO3xeM757NRaZZHOKtk4UixSqvy7431LHEqC-T5w+iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 January 2013 15:38, Arnd Bergmann <arnd@arndb.de> wrote:
> I meant the spear13xx data sheet, which has to list the request lines
> for its integrated components. There may be other SoCs using the
> same dw_dmac, but this is the main one that is upstream now, and it's
> probably as good as any other one. I just wouldn't want to establish
> a binding that doesn't match any of the known implementations in the
> way it expresses request lines.

Your binding (<controller request-line src-master dst-master) is good
enough for SPEAr :)

SPEAr13xx is a bit complex. Request lines are distributed among masters.
+ there is multiplexing among them.. over that there are two controllers..

But yes, your binding is good enough :)

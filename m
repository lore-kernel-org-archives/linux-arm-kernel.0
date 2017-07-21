From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 21 Jul 2017 11:05:47 -0300
Subject: USB PHY reset for Nitrogen6x/MAX
In-Reply-To: <CAAMH-ytNeNc=XOOoEOztL_6Y4jcHHyQ+12pFTaNN-1MQ9kQjFw@mail.gmail.com>
References: <CAAMH-ytNeNc=XOOoEOztL_6Y4jcHHyQ+12pFTaNN-1MQ9kQjFw@mail.gmail.com>
Message-ID: <CAOMZO5D8BZ5pkYri8GU4C=Ag13b7fv7Ze_r2zkjFtyCewcgt0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gary,

On Fri, Jul 21, 2017 at 6:25 AM, Gary Bisson
<gary.bisson@boundarydevices.com> wrote:
> Hi Shawn, Fabio,
>
> Last October I offered the following two patches that add regulators
> to fix USB PHY reset on 2 of our boards:
> https://patchwork.kernel.org/patch/9395531/
> https://patchwork.kernel.org/patch/9395539/
>
> At the time you preferred to wait for Peter's pwrseq sub-system to get
> in to have a proper reset sequence.
>
> Since then, it seems that it's still going to take a long time before
> Peter's series makes it to mainline and many customers of ours
> complained about USB.

Yes, it seems that it may take some more time for Peter's pwrseq to be accepted.

> Would you consider adding back those two patches for next cycle. We
> can still modify them to use pwrseq in the future.

What if you resend the patches stating that it is a temporary
workaround until the generic pwrseq bindings are accepted?

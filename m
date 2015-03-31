From: fabf@skynet.be (Fabian Frederick)
Date: Tue, 31 Mar 2015 21:05:00 +0200 (CEST)
Subject: [PATCH 32/35 linux-next] clk: constify of_device_id array
In-Reply-To: <20150327071935.GB18059@codeaurora.org>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535949-26107-1-git-send-email-fabf@skynet.be>
 <20150318141509.7930.28419@quantum>
 <386731024.185864.1427020449384.open-xchange@webmail.nmp.proximus.be>
 <20150327071935.GB18059@codeaurora.org>
Message-ID: <1336763284.215386.1427828700182.open-xchange@webmail.nmp.proximus.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 27 March 2015 at 08:19 Stephen Boyd <sboyd@codeaurora.org> wrote:
>
>
> On 03/22, Fabian Frederick wrote:
> >
> >
> > > On 18 March 2015 at 15:15 Michael Turquette <mturquette@linaro.org> wrote:
> > >
> > >
> > > Quoting Fabian Frederick (2015-03-16 12:59:06)
> > > > of_device_id is always used as const.
> > > > (See driver.of_match_table and open firmware functions)
> > > >
> > > > Signed-off-by: Fabian Frederick <fabf@skynet.be>
> > >
> > > Acked-by: Michael Turquette <mturquette@linaro.org>
> >
> > Thanks :)
> >
> > btw, something I forgot to mention in changelog is the __initdata ->
> > __initconst
> > for ti_clkdm_match_table[]
> >
> > I can send it again with a new changelog if necessary ...
> >
>
> Did you want us to take this through clk-next? If so please
> resend with the new commit text.

Of course :) I hope V2 is ok.

Regards,
Fabian
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project

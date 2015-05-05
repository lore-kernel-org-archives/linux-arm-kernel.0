From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 5 May 2015 19:12:34 +0200 (CEST)
Subject: [PATCH V2 4/6] DT: add binding for mxs on-chip regulators
In-Reply-To: <201505051021.01939.jbe@pengutronix.de>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
 <201505041551.26355.jbe@pengutronix.de>
 <1858103470.878923.1430770850541.JavaMail.open-xchange@oxbaltgw08.schlund.de>
 <201505051021.01939.jbe@pengutronix.de>
Message-ID: <1195324103.963873.1430845954289.JavaMail.open-xchange@oxbaltgw07.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Juergen,

> J?rgen Borleis <jbe@pengutronix.de> hat am 5. Mai 2015 um 10:21 geschrieben:
>
>
> Hi Stefan,
>
> On Monday 04 May 2015 22:20:50 Stefan Wahren wrote:
> > [...]
> > 
> > I think we have 3 options here:
> >
> > a) add the regulator daisy chain for the i.MX23 too
> > b) remove VDD1P5 from the i.MX28 diagram so it would fit for both again
> > c) remove the diagram complete
> >
> > I would prefer option b. What's your opinion?
>
> I prefer a) because once the details are known, we should keep them.

beside the point this could be to much diagrams for a binding documentation, i
don't have any objections about option a).

>
> Regards,
> Juergen

Regards
Stefan

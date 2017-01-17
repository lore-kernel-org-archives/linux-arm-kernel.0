From: ping.bai@nxp.com (Jacky Bai)
Date: Tue, 17 Jan 2017 06:35:25 +0000
Subject: [PATCH v2 05/12] Document: dt: binding: imx: update pinctrl doc
 for imx6sll
In-Reply-To: <CACRpkda1a4+yOrzBnKs6J84PS0StwQ68gHxDub_u7i5ofU9s7w@mail.gmail.com>
References: <1482832070-22668-1-git-send-email-ping.bai@nxp.com>
 <1482832070-22668-6-git-send-email-ping.bai@nxp.com>
 <CACRpkdYUME8K+JusA0ORRKqxyBuhDdyei8eg7UZbHidKw9=bQw@mail.gmail.com>
 <AM3PR04MB5304992095753B761E66A9A87640@AM3PR04MB530.eurprd04.prod.outlook.com>
 <CACRpkdYTpEHyzBY-mA4YUsj=xt46Pibka3-4VHwUXosfgbgp1Q@mail.gmail.com>
 <AM3PR04MB530A88C5C0E7C6AD2C59B9E87790@AM3PR04MB530.eurprd04.prod.outlook.com>
 <CACRpkda1a4+yOrzBnKs6J84PS0StwQ68gHxDub_u7i5ofU9s7w@mail.gmail.com>
Message-ID: <AM3PR04MB530F532D867C08824DADDC9877C0@AM3PR04MB530.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH v2 05/12] Document: dt: binding: imx: update pinctrl doc
> for imx6sll
> 
> On Thu, Jan 12, 2017 at 3:57 AM, Jacky Bai <ping.bai@nxp.com> wrote:
> 
> > Another thing is that we can use a pins-tool program developed by NXP
> > to  generate the pinctrl configuration code that can be used directly
> > in dts. This tiny program can avoid pin function conflict. As on i.MX,
> > there are so may pins, each pin can be used for up 8  function.
> > Configuring the pins is a time-consuming work.  This tools is very useful for
> customer to generate the dts code.
> 
> I understand, but every silicon vendor has such a tool, all are different,
> proprietary and unfriendly to programmers and open source developers, who
> need to understand how the hardware is working without magic tools and
> secret data sheets to fix bugs.
> 
> For the people working with maintaining the code it is paramount that DTS files
> are self-descriptive.
> 

OK.  Thanks for your comments.  Adding generic-pinconf in imx pinctrl needs some time
to finish and the legacy method still need be here even if generic-pinconf is added. 
Do you plan to pick this legacy binding patch for now?

> Yours,
> Linus Walleij

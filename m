From: leoyang.li@nxp.com (Li Yang)
Date: Tue, 2 Oct 2018 14:45:32 -0500
Subject: [PATCH v2 0/5] soc/fsl/qbman: DPAA QBMan fixes and additions
In-Reply-To: <AM6PR04MB40080234BA68140933F6B733ECE80@AM6PR04MB4008.eurprd04.prod.outlook.com>
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
 <CADRPPNTn99q=6fungYr-xcwY6vFiw9KTUp8UCEQ2u0+sv7vd4Q@mail.gmail.com>
 <AM6PR04MB40080234BA68140933F6B733ECE80@AM6PR04MB4008.eurprd04.prod.outlook.com>
Message-ID: <CADRPPNQmCXwxP7xJh_md37TofRivU6w2EyX1rTTtZX4LGjj+ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 2, 2018 at 1:29 AM Madalin-cristian Bucur
<madalin.bucur@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Li Yang [mailto:leoyang.li at nxp.com]
> > Sent: Tuesday, October 2, 2018 1:30 AM
> > To: Madalin-cristian Bucur <madalin.bucur@nxp.com>
> > Cc: Roy Pledge <roy.pledge@nxp.com>; Claudiu Manoil
> > <claudiu.manoil@nxp.com>; Catalin Marinas <catalin.marinas@arm.com>; Scott
> > Wood <oss@buserror.net>; moderated list:ARM/FREESCALE IMX / MXC ARM
> > ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; linuxppc-dev
> > <linuxppc-dev@lists.ozlabs.org>; lkml <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH v2 0/5] soc/fsl/qbman: DPAA QBMan fixes and additions
> >
> > On Fri, Sep 28, 2018 at 3:44 AM Madalin Bucur <madalin.bucur@nxp.com>
> > wrote:
> > >
> >
> > Applied 1-4 to for-next while waiting for clarification on 5/5.   And
> > updated the prefix to "soc: fsl:" style to be aligned with arm-soc
> > convention.  Please try to use that style in the future for soc/fsl
> > patches.
>
> Thank you, I've sent an email about the APIs.
> I'm not sure we need to align the prefix to arm-soc as the soc/fsl does not
> service only ARM but also PPC based SoCs and historically we've been using
> the soc/* format.

There is no kernel wide guideline about the format of subsystem prefix
in the patch subject. Different subsystems have their own
preferrences.  Soc is not considered as a separate subsystem, so we
followed the convention of the architectural subsystem that we merge
patches through.  Since we normally get soc patches through the
arm-soc tree right now, I think it would be better to follow the
convention of arm-soc to make them not looking too different in the
arm-soc pull requests.  Not sure how sensetive ARM-SOC maintainers
feel about this though.

Regards,
Leo

From: leoyang.li@nxp.com (Li Yang)
Date: Tue, 2 Oct 2018 15:07:30 -0500
Subject: [PATCH v2 5/5] soc/fsl_qbman: export coalesce change API
In-Reply-To: <AM6PR04MB400877EC0C140A7D919AEF41ECE80@AM6PR04MB4008.eurprd04.prod.outlook.com>
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
 <1538124204-31406-6-git-send-email-madalin.bucur@nxp.com>
 <CADRPPNQgGAYTCmppyxPwQnnC433QLm21D5iq_4EvSj0LrsAxGQ@mail.gmail.com>
 <AM6PR04MB400877EC0C140A7D919AEF41ECE80@AM6PR04MB4008.eurprd04.prod.outlook.com>
Message-ID: <CADRPPNSNc50K8EcJUuQ-cnBs4NhHnNnhEDwdTSXgxm0j1FMCTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 2, 2018 at 1:08 AM Madalin-cristian Bucur
<madalin.bucur@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Li Yang [mailto:leoyang.li at nxp.com]
> > Sent: Tuesday, October 2, 2018 12:50 AM
> > To: Madalin-cristian Bucur <madalin.bucur@nxp.com>
> > Cc: Roy Pledge <roy.pledge@nxp.com>; Claudiu Manoil
> > <claudiu.manoil@nxp.com>; Catalin Marinas <catalin.marinas@arm.com>; Scott
> > Wood <oss@buserror.net>; moderated list:ARM/FREESCALE IMX / MXC ARM
> > ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; linuxppc-dev
> > <linuxppc-dev@lists.ozlabs.org>; lkml <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH v2 5/5] soc/fsl_qbman: export coalesce change API
> >
> > On Fri, Sep 28, 2018 at 3:45 AM Madalin Bucur <madalin.bucur@nxp.com>
> > wrote:
> > >
> > > Export the API required to control the QMan portal interrupt coalescing
> > > settings.
> >
> > These are new APIs not just old APIs being exported.  What is the user
> > of these APIs?  Is the user being submitted?  We cannot have APIs in
> > kernel that has no users.
>
> Hi,
>
> These are new APIs that will be used in the DPAA Ethernet driver.
> Changes for the DPAA QBMan and DPAA Ethernet follow different paths upstream
> so the Ethernet driver patch that makes use of these APIs will be sent when
> these changes reach the net-next/master tree.

Applied for next after changing from "export API" to "add API" in the
introduction and updated the subsystem prefix.

Regards,
Leo

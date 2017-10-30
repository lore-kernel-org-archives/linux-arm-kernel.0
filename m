From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 30 Oct 2017 22:46:32 +0800
Subject: [GIT PULL 2/4] i.MX device tree updates for 4.15
In-Reply-To: <CAK8P3a3yb=6gNer8o3yogxOJg43k9KJFQNHhormJP8Rd_f5N+Q@mail.gmail.com>
References: <1508847645-9191-1-git-send-email-shawnguo@kernel.org>
 <1508847645-9191-2-git-send-email-shawnguo@kernel.org>
 <CAK8P3a3yb=6gNer8o3yogxOJg43k9KJFQNHhormJP8Rd_f5N+Q@mail.gmail.com>
Message-ID: <20171030144630.GA6270@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 02:09:49PM +0100, Arnd Bergmann wrote:
> On Tue, Oct 24, 2017 at 2:20 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> 
> > i.MX device tree updates for 4.15:
> >  - New board support: i.MX51 ZII RDU1, i.MX53 GE Healthcare PPD, i.MX6
> >    TX modules for MB7 from  Ka-Ro Electronics, i.MX6 Wandboard revd1
> >    variants, i.MX6 LWN DISPLAY5 board, Pistachio i.MX6Q board, i.MX6SX
> >    Vining-2000 board.
> >  - Use the 'vpcie-supply' property for PCIe device for boards
> >    imx6qdl-sabresd, imx6q-novena and imx6q-cm-fx6.
> >  - A series from Jagan Teki to update imx6qdl-icore board with audio,
> >    touch and CAN support.
> >  - Switch to nvmem for accessing OCOTP from tempmon for i.MX6SX and add
> >    tempmon support for i.MX6UL.
> >  - A bunch of patches from Lothar Wa?mann updating Ka-Ro i.MX28, i.MX53
> >    and i.MX6 TX modules.
> >  - Fix DTC warnings in i.MX device trees, dropping leading zeros from
> >    unit address, correcting display nodes notation and display port
> >    names, fixing nodes with unit name and no reg property.
> 
> I got some conflicts against the patch from Rob to drop leading zeros,
> but those were all easy to fix up. I noticed that some of your newly
> added files have new leading zeros, so I removed them during the merge
> as well. Please double-check that the new version in branch next/dt is
> fine.

I compared your next/dt and my imx/dt, and the diff is all about
dropping leading zeros.  So next/dt branch is fine.

Thanks a lot for helping fix it up.  I will pay more attention to
leading zeros for future patch reviewing.

Shawn

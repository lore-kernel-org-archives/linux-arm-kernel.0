From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 5 Nov 2016 15:00:45 +0800
Subject: [PATCH] ARM: dts: imx6: Add support for Logic PD SOM and Baseboard
In-Reply-To: <CAHCN7x+YopHVNxh4Vi5o1d=S3FFkoz45dNmgHMgs1sAQqaL77A@mail.gmail.com>
References: <1469030786-28424-1-git-send-email-aford173@gmail.com>
 <20160809082400.GR4678@tiger>
 <CAHCN7x+YopHVNxh4Vi5o1d=S3FFkoz45dNmgHMgs1sAQqaL77A@mail.gmail.com>
Message-ID: <20161105070043.GA5597@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 12:44:21PM -0500, Adam Ford wrote:
> >> +&iomuxc {
> >> +     imx6qdl-logicpd-baseboard {
> >> +
> >
> > Drop this container node and put the following pinctrl nodes directly
> > under &iomuxc.
> >
> 
> Like the regulators above, if I remove this connector, the system
> won't boot.  I compared both the regulator and the iomuxc containers
> in this device tree with other imx6q boards, and I seem to be
> consistent with what other boards are doing.

You might want to rebase the patch to latest mainline like v4.9-rc3 and
test first.

Shawn

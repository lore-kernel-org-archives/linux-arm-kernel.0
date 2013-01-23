From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 12:40:25 -0500
Subject: [PATCH v2 1/3] arm: mvebu: Add support for USB host
 controllers in Armada 370/XP
In-Reply-To: <CALF0-+W8dVLHF66VKni+5ZsQpFd=cGDXE0TD=dRc1B=ptrAMUg@mail.gmail.com>
References: <1358954792-16160-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <CALF0-+W8dVLHF66VKni+5ZsQpFd=cGDXE0TD=dRc1B=ptrAMUg@mail.gmail.com>
Message-ID: <20130123174025.GV1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 02:06:12PM -0300, Ezequiel Garcia wrote:
> Jason,
> 
> On Wed, Jan 23, 2013 at 12:26 PM, Ezequiel Garcia <ezequiel.garcia@free-electrons.com> wrote:
> > The Armada 370 and Armada XP SoC has an Orion EHCI USB controller.
> > This patch adds support for this controller in Armada 370
> > and Armada XP SoC common device tree files.
> >
> > Cc: Lior Amsalem <alior@marvell.com>
> > Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Tested-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > Tested-by: Florian Fainelli <florian@openwrt.org>
> > Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> > Changes from v1:
> >  * Remove uneeded USB_ARCH_HAS_EHCI selection as noted by Florian.
> >
> >  arch/arm/boot/dts/armada-370-xp.dtsi |   15 +++++++++++++++
> >  arch/arm/boot/dts/armada-370.dtsi    |    9 +++++++++
> >  arch/arm/boot/dts/armada-xp.dtsi     |   17 +++++++++++++++++
> >  3 files changed, 41 insertions(+), 0 deletions(-)
> 
> Do you think we're still in time to get this series into v3.9 (given
> we decide soon on the OpenBlocks issue)?

That shouldn't be a problem.

thx,

Jason.

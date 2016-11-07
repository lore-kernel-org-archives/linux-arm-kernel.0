From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 7 Nov 2016 09:10:18 +0800
Subject: [PATCH 1/9] ARM: dts: imx1: Remove skeleton.dtsi
In-Reply-To: <CAOMZO5CUyZF5wXBxvcsJWSLt1NVzejpH0bZKedJfx3TfBPB2vQ@mail.gmail.com>
References: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
 <CAOMZO5CUyZF5wXBxvcsJWSLt1NVzejpH0bZKedJfx3TfBPB2vQ@mail.gmail.com>
Message-ID: <20161107011017.GA14622@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 05, 2016 at 05:35:50PM -0200, Fabio Estevam wrote:
> Hi Shawn,
> 
> On Tue, Sep 6, 2016 at 12:53 PM, Fabio Estevam <fabio.estevam@nxp.com> wrote:
> > The inclusion of skeleton.dtsi causes the following build warning:
> >
> > Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
> >
> > Instead of fixing skeleton.dtsi, just add the top level definitions
> > for address-cells and size-cell and remove its inclusion.
> >
> > Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Are you OK with this series?

Has the series cleaned up all i.MX dts files?  I do not like to see so
many patches doing such small cleanups.  Can we do it with 3 patches
maybe?

 - one for skeleton.dtsi cleanup
 - one for memory node
 - one for cpu node

Each one covers all i.MX dts files.

Shawn

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Dec 2013 21:48:52 +0000
Subject: [PATCH 2/2] ARM: imx: update imx_v6_v7_defconfig
In-Reply-To: <CAOMZO5AOGgHcC7phcsc3OEBrov52DwSoys7tLVSJ8=WGfWDYKA@mail.gmail.com>
References: <20131217194130.GA4360@n2100.arm.linux.org.uk>
 <E1Vt0XX-0007Bw-Ry@rmk-PC.arm.linux.org.uk>
 <CAOMZO5AOGgHcC7phcsc3OEBrov52DwSoys7tLVSJ8=WGfWDYKA@mail.gmail.com>
Message-ID: <20131217214852.GB4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 06:22:40PM -0200, Fabio Estevam wrote:
> On Tue, Dec 17, 2013 at 5:42 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > Update the IMX v6/v7 defconfig for the SolidRun HummingBoard:
> > - Add AT803X ethernet phy
> > - Add consumer IR devices
> > - Add imx-drm HDMI output
> 
> No HDMI related option is being added in this patch.

True - Shawn/Sascha - do you want to edit that out of the commit log or
shall I resend?

Thanks.

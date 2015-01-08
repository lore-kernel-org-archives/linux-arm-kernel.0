From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 08 Jan 2015 15:53:15 +0100
Subject: [PATCH RFC V3 2/3] mxs: add driver for ocotp in i.MX23 and i.MX28
In-Reply-To: <54AE8D45.7050805@imgtec.com>
References: <1413628372-2809-1-git-send-email-stefan.wahren@i2se.com>
 <2223659.OW08fe0cS1@wuerfel>
 <1003885907.22061.1415301932743.JavaMail.open-xchange@oxbsltgw00.schlund.de>
 <6087001.lBonPVHV5K@wuerfel> <54AE8D45.7050805@imgtec.com>
Message-ID: <54AE99DB.1070300@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

Am 08.01.2015 um 14:59 schrieb Ezequiel Garcia:
> Hi Stefan, Arnd,
>
> (I'm trimming the Cc list and adding Thierry and Maxime to the loop):
>
> I'm in the process of finding a suitable upstream path for a new eFuse driver
> for fuses used on Imagination Technologies SoCs.
>
> This was our last proposal, which follows Tegra's work:
>
> http://www.spinics.net/lists/devicetree/msg59246.html
>
> However, Arnd was reluctant to take yet another efuse driver under drivers/soc
> and proposed instead to try to find a unified API. We've had numerous fuse
> drivers (tegra, sunxi, imx and img) appearing, so his concern certainly makes
> sense.
>
> I've talked to Arnd on IRC and we agreed to create a new directory
> drivers/efuse. As a first step we would just move the tegra driver,
> and add the new drivers (img on my side, and possibly mxs on Stefan's).
> Perhaps we would also pull the sunxi_sid driver as well.
>
> Having the drivers together would allow us to come up with a unified API
> as follow up work.

does this unified API affects userspace interface, internal kernel
interface or both?

> How does this sound? If you have no objections to this, I can go ahead and
> try to prepare some RFCs.

I'm happy about any progress on this. It's not really urgent for me to
get the driver into mainline. A helpful and useable userspace interface
is more important to me. So i want to send my comments/requirements
about the API and post the mxs driver after the definition of the
unified API.

Does this answer your question?

Stefan

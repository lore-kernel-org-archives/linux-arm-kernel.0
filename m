From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 28 Nov 2017 14:31:03 -0200
Subject: [PATCH v2 00/16] SolidRun Hummingboard DT updates
In-Reply-To: <20171128150045.GV31757@n2100.armlinux.org.uk>
References: <20171128150045.GV31757@n2100.armlinux.org.uk>
Message-ID: <CAOMZO5B6KEbmrgm3An=NXidD8Lfu35dMebWPPbLzjFL8Bmuupw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 1:00 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> Hi Shawn,
>
> This series updates the SolidRun Hummingboard platforms to:
> (a) make the DT more reflective of the schematics
> (b) re-organise how we deal with the differences between various board
>     versions in preparation for the new 1.5 SOM.
>
> The idea with (b) is that we add the support for the board + usom
> combination by including the appropriate dtsi files.
>
> For example, in mainline at the moment, we support two variants of the
> Hummingboards - both with Broadcom Wi-Fi and without eMMC.  Going
> forward, when a 1.5 SOM is fitted (which modern Hummingboards will all
> have) the boards will have TI Wi-Fi and potentially eMMC on the usom.
>
> This series adds the dtsi files for the new SOM and dts files for the
> platform variants (v1.5 SOM without eMMC, v1.5 SOM with eMMC.)  It's
> unfortunate that the w/o eMMC variant can't detect the lack of eMMC,
> running the eMMC version without eMMC on the boards results in an
> almost constant stream of kernel messages.
>
> Feedback from the previous posting has been addressed, and additional
> changes adding the v1.5 SOM board level files added through discussion
> with Jon.

Looks good, thanks.

For the whole series:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

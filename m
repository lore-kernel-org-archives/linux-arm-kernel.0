From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Aug 2015 13:15:40 -0700
Subject: [GIT PULL 2/3] ARM: imx: device tree changes for 4.3
In-Reply-To: <1439311351-5268-2-git-send-email-shawnguo@kernel.org>
References: <1439311351-5268-1-git-send-email-shawnguo@kernel.org>
 <1439311351-5268-2-git-send-email-shawnguo@kernel.org>
Message-ID: <20150818201540.GB4732@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:42:30AM +0800, Shawn Guo wrote:
> Hi arm-soc maintainers,
> 
> This is the i.MX device tree updates for 4.3.  To resolve the dependency
> between imx6ul clock driver and DTS files on those clock ID definitions,
> the i.MX clock changes are pulled into the branch.  But since i.MX clock
> drivers are now in drivers/clk/imx/ folder, I sent the clock changes to
> Mike and Stephen.  I've already asked them to keep my clock branch
> stable/non-reabasable.  So it should be safe pull this DT change set
> into arm-soc.
> 
> Shawn
> 
> The following changes since commit 787b4271a6a0c09775241770782b22762f40bd6e:
> 
>   clk: imx: add imx6ul clk tree support (2015-07-14 15:02:13 +0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.3
> 
> for you to fetch changes up to 360325755336893869c419013ec0e33757432cbb:
> 
>   ARM: dts: imx6ul: add snvs power key support (2015-08-11 23:15:27 +0800)
> 
> ----------------------------------------------------------------
> The i.MX device tree updates for 4.3:
>  - Add audio and eTSEC device support and update dspi node for LS1021A.
>  - Add initial i.MX6UL and imx6ul-14x14-evk board support, and enable
>    a bunch of device support for i.MX6UL, including RTC, power key, USB,
>    QSPI, and dual FEC.
>  - Enable HDMI and LVDS dual display support for a few imx6qdl boards.
>  - Support of imx6sl-warp board rev1.12, the version which will be
>    publicly available for the customers.
>  - A few i.MX7D device additions, watchdog, cortex-a7 coresight
>    components, RTC, power key, power off.
>  - Some Vybrid updates: add device support for I2C, QSPI, eSDHC etc.,
>    update ADC node, and define stdout-path property.
>  - A few random updates for i.MX27 and i.MX53 devices.
> 

Merged, thanks.


-Olof

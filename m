From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 19 Apr 2016 14:41:26 +0200
Subject: [PATCH 0/8] STMPE fixes/rework and add STMPE1600 support
In-Reply-To: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
References: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
Message-ID: <20160419124126.GF8284@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 02:18:29PM +0200, patrice.chotard at st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> This series cleans and fixes some bugs in MFD/GPIO STMPE drivers and prepare
>  the ground to add new STMPE1600 support.
> 
> STMPE1600 datasheet is available here : 
> http://www2.st.com/content/st_com/en/products/interfaces-and-transceivers/
> i-o-expanders-and-level-translators/i-o-expanders/stmpe1600.html
> 
> Only STMPE1600 has been tested on STM32 platform. As i have no board with
> others STMPE variant(STMPE610/STMPE801/STMPE811/STMPE1601/STMPE1801/STMPE2401
> and STMPE2403), i put in CC boards's maintainers which are using others STMPE variant.
> 
> If they can kindly check that no regression has been introduce by this series
> :
> 
> For ARM/FREESCALE IMX / MXC ARM ARCHITECTURE:
> 	_ Shawn Guo <shawnguo@kernel.org>
> 	_ Sascha Hauer <kernel@pengutronix.de>
> 
> For ARM/SOCFPGA ARCHITECTURE
> 	_ Dinh Nguyen <dinguyen@opensource.altera.com>
> 
> For SPEAR PLATFORM SUPPORT
> 	_ Viresh Kumar <vireshk@kernel.org>
> 	_ Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> 
> For TEGRA ARCHITECTURE SUPPORT
> 	_ Stephen Warren <swarren@wwwdotorg.org>
> 	_ Thierry Reding <thierry.reding@gmail.com>
> 	_ Alexandre Courbot <gnurou@gmail.com> 

Adding Marcel Ziswiler, who's better suited at judging whether or not
this has any impact on Apalis/Colibri.

Marcel, in case you don't have these in your inbox you can find them on
linux-gpio's patchwork:

	https://patchwork.ozlabs.org/project/linux-gpio/list/

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160419/ef7ce9b0/attachment.sig>

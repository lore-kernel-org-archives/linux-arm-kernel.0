From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Nov 2014 21:33:33 +0800
Subject: [PATCH v6 1/3] ARM: dts: pbab01: move i2c pins and frequency
 configuration into pfla02
In-Reply-To: <1415106349-18846-2-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1415106349-18846-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1415106349-18846-2-git-send-email-d.lavnikevich@sam-solutions.com>
Message-ID: <20141111133331.GA2704@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 04:05:47PM +0300, Dmitry Lavnikevich wrote:
> Since pins and frequency are specific to module (pfla02), not base board
> (pbab02), it is better to be initialized in corresponding dts file.
> 
> This patch fixes i2c2, i2c3 pin configuration which caused messages:
> 
> imx6q-pinctrl 20e0000.iomuxc: no groups defined in /soc/aips-bus at 02000000/iomuxc at 020e0000/i2c2grp
> imx6q-pinctrl 20e0000.iomuxc: no groups defined in /soc/aips-bus at 02000000/iomuxc at 020e0000/i2c3grp
> imx6q-pinctrl 20e0000.iomuxc: unable to find group for node i2c2grp
> imx6q-pinctrl 20e0000.iomuxc: unable to find group for node i2c3grp
> 
> Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>

Applied all 3, thanks.

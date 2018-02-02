From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 2 Feb 2018 13:43:59 +0800
Subject: [PATCH] ARM: imx: Remove epit support
In-Reply-To: <1515511483-24706-1-git-send-email-fabio.estevam@nxp.com>
References: <1515511483-24706-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20180202054358.GJ20833@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 01:24:43PM -0200, Fabio Estevam wrote:
> Currently there is no user of EPIT, so remove such unused code.
> 
> If someone wants to add EPIT support back, then the person needs to
> create a proper support into drivers/clocksource/ and add device
> tree support, proper bindings, etc.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.

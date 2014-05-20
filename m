From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 May 2014 22:51:22 -0700
Subject: [PATCH] ARM: add drivers for Colibri T30 to multi_v7_defconfig
In-Reply-To: <537503FA.5070605@wwwdotorg.org>
References: <1400103110-17574-1-git-send-email-stefan@agner.ch>
 <537503FA.5070605@wwwdotorg.org>
Message-ID: <20140520055122.GP18956@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 12:14:18PM -0600, Stephen Warren wrote:
> On 05/14/2014 03:31 PM, stefan at agner.ch wrote:
> > From: Stefan Agner <stefan@agner.ch>
> > 
> > Toradex Colibri Evaluation Board uses the DS1307 RTC and the
> > MCP251x CAN controller. The NVIDIA Tegra 3 based Colibri T30
> > module can be used on this carrier board, hence enable those
> > drivers in tegra_defonfig and multi_v7_defconfig.
> > 
> > Furthermore the NVIDIA Tegra 3 based Apalis T30 module too
> > contains two MCP251x CAN controller.
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>

Applied.


-Olof

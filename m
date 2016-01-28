From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 28 Jan 2016 14:36:40 +0800
Subject: [PATCH] [ARM] i.MX6: fix cleanup path in imx6q_suspend_init()
In-Reply-To: <569BD501.6040308@tribudubois.net>
References: <1451168168-24303-1-git-send-email-jcd@tribudubois.net>
 <569BD501.6040308@tribudubois.net>
Message-ID: <20160128063640.GK9070@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 17, 2016 at 06:53:05PM +0100, Jean-Christophe DUBOIS wrote:
> Shawn, Sascha,
> 
> Are you OK with this patch?
> 
> JC
> 
> Le 26/12/2015 23:16, Jean-Christophe Dubois a ?crit :
> >The wrong pointer is passed to the ioumap function in the cleanup path
> >
> >Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>

Applied, thanks.

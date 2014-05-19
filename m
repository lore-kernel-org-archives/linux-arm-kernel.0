From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 19 May 2014 13:25:23 +0800
Subject: [PATCH 2/2] ARM: i.MX: Select HAVE_IMX_SRC for i.MX5 globally
In-Reply-To: <1400088614-27280-2-git-send-email-shc_work@mail.ru>
References: <1400088614-27280-1-git-send-email-shc_work@mail.ru>
 <1400088614-27280-2-git-send-email-shc_work@mail.ru>
Message-ID: <20140519052522.GH10685@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 09:30:14PM +0400, Alexander Shiyan wrote:
> No reason to choose a symbol HAVE_IMX_SRC separately for each supported
> i.MX5 CPU, this patch selects this symbol globally for i.MX5.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied, thanks.

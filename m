From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 11 Apr 2013 14:08:44 -0400
Subject: [PATCH v3 4/9] ARM: mvebu: Enable pj4b on LPAE compilations
In-Reply-To: <1365461538-30702-5-git-send-email-gregory.clement@free-electrons.com>
References: <1365461538-30702-1-git-send-email-gregory.clement@free-electrons.com>
 <1365461538-30702-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130411180844.GO28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 12:52:12AM +0200, Gregory CLEMENT wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> pj4b cpus are LPAE capable so enable them on LPAE compilations
> 
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Tested-by: Franklin <flin@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mm/proc-v7.S |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to mvebu/soc

thx,

Jason.

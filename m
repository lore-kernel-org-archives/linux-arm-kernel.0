From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 27 Oct 2010 11:15:25 +0200
Subject: [PATCH 2/2] [ARM] Dove: add support for multi-purpose pins
	configuration
In-Reply-To: <FCBE654890C0334289D0AD3AF4EF009FE1475AA36F@IL-MB01.marvell.com>
References: <cover.1288166960.git.mike@compulab.co.il>
	<63829134f147c923e9785f62482183efcbe62cc0.1288166961.git.mike@compulab.co.il>
	<FCBE654890C0334289D0AD3AF4EF009FE1475AA36F@IL-MB01.marvell.com>
Message-ID: <4CC7EDAD.8050009@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/10 11:01, Saeed Bishara wrote:
> +static void dove_mpp_conf_grp(int num, int sel, u32 *mpp_ctrl)
> +{
> +	int start = dove_mpp_grp[num].start;
> +	int end = dove_mpp_grp[num].start;
> Shouldn't that be dove_mpp_grp[num].end ?

oops.. thanks, will fix and resend

> saeed


-- 
Sincerely yours,
Mike.

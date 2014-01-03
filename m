From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 3 Jan 2014 19:49:29 +0100
Subject: [PATCH v2 2/2] i2c: mv64xxx: Fix bus hang on A0 version of the
 Armada XP SoCs
In-Reply-To: <1388743185-24822-3-git-send-email-gregory.clement@free-electrons.com>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <1388743185-24822-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140103194929.706f93c6@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Fri,  3 Jan 2014 10:59:45 +0100, Gregory CLEMENT wrote:

> +		/*
> +		 * Only revison more recent than A0 support offload

revison -> revisions

offload mechanism -> the offload mechanism

> +		 * mechanism. In case we can't get the SoC revision
> +		 * weplay safe and we don't enable it

weplay -> we play

> +		 */
> +		if (mvebu_get_soc_id(&rev, &dev) == 0 && dev > MV78XX0_A0_REV)
> +			drv_data->offload_enabled = true;
>  	}
>  
>  out:

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

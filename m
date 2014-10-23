From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 23 Oct 2014 20:41:00 +0200
Subject: [PATCH 1/4] ARM: mvebu: Clean-up the Armada XP support
In-Reply-To: <1414088070-12510-2-git-send-email-gregory.clement@free-electrons.com>
References: <1414088070-12510-1-git-send-email-gregory.clement@free-electrons.com>
 <1414088070-12510-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20141023204100.7cd93f08@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Thu, 23 Oct 2014 20:14:27 +0200, Gregory CLEMENT wrote:

> +/*
> + * The following field (.smp) is stil needed to ensure backward

stil -> still

> + * compatibility with the old device trees

It would be good to be more specific here:

	The following field (.smp) is still needed to ensure backward
	compatibility with old Device Trees that were not specifying
	the cpus enable-method property.

Other than that, looks good to me.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

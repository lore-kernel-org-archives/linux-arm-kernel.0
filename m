From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Mar 2012 15:08:13 -0800
Subject: [PATCH v2 1/2] ARM: OMAP2+: id: Add am33xx SoC type detection
In-Reply-To: <1329113685-7500-1-git-send-email-afzal@ti.com>
References: <1329113685-7500-1-git-send-email-afzal@ti.com>
Message-ID: <20120305230812.GO12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Afzal Mohammed <afzal@ti.com> [120212 22:00]:
> Determine SoC type, i.e. whether GP or HS
> 
> Note: cpu_is_34xx() is true for am33xx also. Doing
> cpu_is_am33xx() check after cpu_is_34xx() will not
> achieve what we want due to the above reason.
> Hence cpu_is_am33xx() is done before cpu_is_34xx()

Thanks, applying into fixes-non-critical-part2.

Tony

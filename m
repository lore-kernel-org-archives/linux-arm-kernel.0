From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Oct 2015 15:08:13 +0200
Subject: [PATCH 1/4] vfio: platform: add capability to register a reset
 function
In-Reply-To: <1445184015-24414-2-git-send-email-eric.auger@linaro.org>
References: <1445184015-24414-1-git-send-email-eric.auger@linaro.org>
 <1445184015-24414-2-git-send-email-eric.auger@linaro.org>
Message-ID: <4603273.vQZIH2Gpzn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 18 October 2015 18:00:12 Eric Auger wrote:
> 
> +struct list_head reset_list;
> +LIST_HEAD(reset_list);
> 

These two should be marked 'static'.

	Arnd

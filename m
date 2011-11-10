From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Nov 2011 15:44:12 -0800
Subject: [PATCH v8 04/16] ARM: LPAE: Move the FSR definitions to
 separate files
In-Reply-To: <1320682618-1182-5-git-send-email-catalin.marinas@arm.com>
References: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
 <1320682618-1182-5-git-send-email-catalin.marinas@arm.com>
Message-ID: <20111110234411.GC31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Catalin Marinas <catalin.marinas@arm.com> [111107 07:59]:
> +	{ do_bad,		SIGBUS,  0,		"unknown 29"			   },
> +	{ do_bad,		SIGBUS,  0,		"unknown 30"			   },
> +	{ do_bad,		SIGBUS,  0,		"unknown 31"			   }

Maybe add the trailing comma here while at it? :)

Regards,

Tony

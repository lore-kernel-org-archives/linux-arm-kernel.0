From: joe@perches.com (Joe Perches)
Date: Thu, 22 Jul 2010 18:57:29 -0700
Subject: [PATCH] Add support for Vista Silicon Visstrim_m10 board [v5].
In-Reply-To: <1279795695-6211-1-git-send-email-javier.martin@vista-silicon.com>
References: <1279795695-6211-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1279850249.1909.76.camel@Joe-Laptop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-07-22 at 12:48 +0200, Javier Martin wrote:
[]
> +#define pr_fmt(fmt) "visstrim_m10: " fmt

I think it'd be better to use:

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

cheers, Joe

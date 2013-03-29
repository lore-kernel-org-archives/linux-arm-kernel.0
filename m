From: acourbot@nvidia.com (Alex Courbot)
Date: Fri, 29 Mar 2013 08:24:59 -0700
Subject: [PATCH 0/3] gpio: remove GENERIC_GPIO completely
In-Reply-To: <1364562678-8945-1-git-send-email-acourbot@nvidia.com>
References: <1364562678-8945-1-git-send-email-acourbot@nvidia.com>
Message-ID: <5155B24B.2030601@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2013 06:11 AM, Alexandre Courbot wrote:
> If I can get a few acks on these (or at least the first two ones) I'd like to
> include them into my next branch as soon as possible so points of breakage can
> be fixed. There are indeed a few new users of GENERIC_GPIO (CC Romain, I sent a
> warning but saw no action so far) in the next tree and compilation will break
> for them.

Alternatively, Grant may want to pull all the patches I did so far - 
they are in next for more than 10 days now and no complain has been 
raised. Also it's probably better to keep all GPIO-related changes into 
the same tree.

Alex.

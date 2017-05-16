From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 May 2017 08:09:20 -0700
Subject: [PATCH] dt: gta04: fix polarity of clocks for mcbsp4
In-Reply-To: <1493375255-21094-1-git-send-email-andreas@kemnade.info>
References: <1493375255-21094-1-git-send-email-andreas@kemnade.info>
Message-ID: <20170516150919.GB31418@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andreas Kemnade <andreas@kemnade.info> [170428 03:30]:
> The clock polarity setting of the mcbsp connected to
> the modem was wrong so almost only noise
> was received.
> With this patch it is also the same as it was on
> earlier non-dt kernels where it was working properly

Applying into omap-for-v4.12/fixes.

Thanks,

Tony

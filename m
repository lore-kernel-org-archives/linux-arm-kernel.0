From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 07 May 2015 18:39:21 +0200
Subject: [PATCH 1/2] coresight: replicator: Add Qualcomm CoreSight
 Replicator driver
In-Reply-To: <1431010007.21307.10.camel@linaro.org>
References: <1430310000-10867-1-git-send-email-ivan.ivanov@linaro.org>
 <1430310000-10867-2-git-send-email-ivan.ivanov@linaro.org>
 <1430427225.2187.15.camel@x220> <1431010007.21307.10.camel@linaro.org>
Message-ID: <1431016761.8171.79.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-05-07 at 17:46 +0300, Ivan T. Ivanov wrote:
> Thank you. I am going to fallow approach taken by Mathieu in [1].
> Is this OK with you?

I'm OK with anything that is coherent (ie, anything better than built-in
only code cross-dressing as modular code). I think Mathieu's approach
clears that bar. (Please note that macros like module_amba_driver() are
basically just a pet peeve.)

And, at the end of the day, what matters is what the maintainer of this
code accepts. I'm not the maintainer here.

Thanks,


Paul Bolle

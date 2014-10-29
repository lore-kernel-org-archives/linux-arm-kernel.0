From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 29 Oct 2014 13:06:05 -0700
Subject: [PATCH v6 0/7] This is the 1st version of suspend for RK3288.
In-Reply-To: <1414583525-17395-1-git-send-email-zyw@rock-chips.com> (Chris
 Zhong's message of "Wed, 29 Oct 2014 19:51:58 +0800")
References: <1414583525-17395-1-git-send-email-zyw@rock-chips.com>
Message-ID: <7hppda7iaa.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

Chris Zhong <zyw@rock-chips.com> writes:

> RK3288 can shut down the cpu, gpu and other device controllers in suspend,
> and it will pull the GLOBAL_PWROFF pin to high in the final stage of the
> process of suspend, pull the pin to low again when resume.

I tried to test this on top of linux-next (next-20141029) and it doesn't
wake up from serial port activity.

Can you describe how to test this, as well as describe dependencies on
other out-of-tree patches, including pointers to where they've been
posted.

Also, please describe how you tested this and on which hardware
platforms.  It's a big help to reviewers to know how it's been tested,
and for anyone with similar hardware to know what else it's been tested
on.

Thanks,

Kevin

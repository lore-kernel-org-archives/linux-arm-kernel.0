From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 29 Nov 2017 15:04:12 +0000
Subject: [PATCH v5 00/30] ARM Scalable Vector Extension (SVE)
In-Reply-To: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
References: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <877eu9dt3n.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> This series implements Linux kernel support for the ARM Scalable Vector
> Extension (SVE). [1]  It supersedes the previous v3: see [3] for link
> and full cover letter.
>
> This is a minor update to v4, but does contain a couple of important
> fixes.
<snip>

I seem to have run into a regression with normal non-SVE sigcontexts
while trying to run consecutive RISU runs in the Foundation Model. I'm
failing to get repeatable results playing back a previous --master run.
It works OK with the default Debian kernel.

What is the current status of the tree? I'd like to try an narrow it
down but I seem to recall it was now in a next tree somewhere?

--
Alex Benn?e

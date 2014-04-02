From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 02 Apr 2014 16:26:00 -0700
Subject: [PATCH 1/2] ARM: add cpu_is_pj4() to distinguish PJ4 core
In-Reply-To: <533B1F27.9010504@wwwdotorg.org> (Stephen Warren's message of
 "Tue, 01 Apr 2014 14:18:47 -0600")
References: <1395385319-25386-1-git-send-email-chao.xie@marvell.com>
 <533B1F27.9010504@wwwdotorg.org>
Message-ID: <7hwqf71fg7.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 03/21/2014 01:01 AM, Chao Xie wrote:
>> PJ4 is based on V7, but it has some changes. For example, some
>> coprocessor settings.
>
> I don't see this patch in linux-next, yet I think the runtime problem
> has gone away somehow. How did that happen?

The multi_v7 change that introduced the regression (addtion of
MACH_DOVE) was reverted in arm-soc/for-next while waiting for the patch
to be submitted to Russell's tracker.

Looks like they've now been submitted to the tracker, so hopefully
Russell will get to them on his next pass.  They'll be needed for v3.15.

Kevin

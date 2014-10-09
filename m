From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 09 Oct 2014 13:47:37 -0700
Subject: [PATCH v3] ARM: dts: Add initial DTS file for Sony Xperia Z1 phone
In-Reply-To: <6FB01741-5960-45CE-9AB8-20CBE5D9D212@codeaurora.org> (Kumar
 Gala's message of "Thu, 9 Oct 2014 13:22:37 -0500")
References: <542B338D.2040909@sonymobile.com>
 <CA+bK7J5x60WyyAp6+hGDf-fyAC=skQu9EdPUabPrzhMCDnOCrA@mail.gmail.com>
 <6FB01741-5960-45CE-9AB8-20CBE5D9D212@codeaurora.org>
Message-ID: <7h4mvdnf6e.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kumar,

Kumar Gala <galak@codeaurora.org> writes:

> Will not make the 3.18 merge window.  I will queue it up for 3.19.

Yes, it's too late for the merge window proper, but since it's DT only
support for new platform, you can submit it as a fix to us (arm-soc) for
v3.18-rc.

In fact, if you chose (and if it's known to work for v3.17 and/or
earlier), you can even mark it for stable.  Greg has said he's OK with
DT-only changes like this that only affect a specific platform to go
into stable.

Kevin

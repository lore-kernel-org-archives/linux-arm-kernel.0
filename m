From: jcm@jonmasters.org (Jon Masters)
Date: Mon, 19 Feb 2018 18:46:14 -0500
Subject: [PATCH] arm64: Make L1_CACHE_SHIFT configurable
In-Reply-To: <126b2cc2-a61e-b30d-1ff9-ea30af7abf57@gmail.com>
References: <1518479125-14428-1-git-send-email-f.fainelli@gmail.com>
 <ca6c47f9-86df-bcdb-bbe1-eac9db68ec33@codeaurora.org>
 <ffc090d5-62c9-e608-32e2-8d13d01234e6@gmail.com>
 <f5d6d768-d354-56b5-ce0c-4f46d4e6d642@codeaurora.org>
 <126b2cc2-a61e-b30d-1ff9-ea30af7abf57@gmail.com>
Message-ID: <9a5190d1-eb8d-0275-d8d9-39de622a679c@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2018 07:17 PM, Florian Fainelli wrote:
> On 02/12/2018 04:10 PM, Timur Tabi wrote:
>> On 02/12/2018 05:57 PM, Florian Fainelli wrote:
>>> That is debatable, is there a good publicly available table of what the
>>> typical L1 cache line size is on ARMv8 platforms?

With a server hat on...

There are many ARMv8 server platforms that do 64b today, but future
designs are likely to head toward 128b (for a variety of reasons). Many
of the earlier designs were 64b because that's what certain other arches
were using in their server cores. I doubt Vulcan will remain a unique
and special case for very long. On the CCIX side of things, I've been
trying to push people to go with 128b lines in future designs too.

Jon.

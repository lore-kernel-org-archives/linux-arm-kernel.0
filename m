From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 6 Feb 2017 09:13:44 +0530
Subject: [PATCH 1/2] DTS: dra7: Replace obsolete "operating-points"
 property with "operating-points-v2"
In-Reply-To: <1486135491-14223-1-git-send-email-lukma@denx.de>
References: <1486135491-14223-1-git-send-email-lukma@denx.de>
Message-ID: <20170206034344.GF3131@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03-02-17, 16:24, Lukasz Majewski wrote:
> The "operating-points" property have been replaced with
> "operating-points-v2". Only entries with the same frequencies have
> been added, so no reqression should be introduced.

Don't use "obsolete" word here. Its not obsolete and both bindings
will be supported.

-- 
viresh

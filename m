From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Nov 2016 08:50:56 -0700
Subject: ILP32 for ARM64: testing with glibc testsuite
In-Reply-To: <CC4F99A7-1FD2-486A-BD66-ED06F1B8BF50@linaro.org>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161107082359.GA19666@yury-N73SV>
 <20161109095650.GA22804@yury-N73SV>
 <CC4F99A7-1FD2-486A-BD66-ED06F1B8BF50@linaro.org>
Message-ID: <20161117155056.6xkldspks6dwoj7z@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 03:22:26PM +0400, Maxim Kuvyrkov wrote:
> Regarding ILP32 runtime, my opinion is that it is acceptable for ILP32
> to have extra failures compared to LP64, since these are not
> regressions, but, rather, failures of a new configuration.

I disagree with this. We definitely need to understand why they fail,
otherwise we run the risk of potential glibc or kernel implementation
bugs becoming ABI.

-- 
Catalin

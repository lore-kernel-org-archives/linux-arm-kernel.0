From: valentin.schneider@arm.com (Valentin Schneider)
Date: Tue, 16 Oct 2018 11:01:30 +0100
Subject: [BUG] hikey960: psci: Failure to boot CPU after hotplug
In-Reply-To: <cf313cf7-c416-2693-8a9d-0d6f122f2018@arm.com>
References: <cf313cf7-c416-2693-8a9d-0d6f122f2018@arm.com>
Message-ID: <e842855e-e99a-378e-49ec-187384e1418c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/2018 19:00, Valentin Schneider wrote:
> [...]

This was initially sent on Sunday but only got delivered today. In the
meantime I dug a bit deeper and I think it has to do with the firmware
implementation of PSCI. I raised a ticket for ATF ([1]).

[1]: https://github.com/ARM-software/tf-issues/issues/638

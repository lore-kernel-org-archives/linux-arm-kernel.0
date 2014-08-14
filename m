From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 14 Aug 2014 12:15:48 +0100
Subject: [RFC PATCH 0/3] arm: FIQ IPI support
In-Reply-To: <53EC9404.5010908@linaro.org>
References: <53EC9404.5010908@linaro.org>
Message-ID: <1408014951-24820-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a work-in-progress set of patches to add support for
implementing IPIs using FIQ. Currently KGDB is the only user
of this feature although others could easily be added due to
the use of notifier chains.

Patches depend on the KGDB NMI/FIQ patch series. I'll send
a complete patchset for the KGDB NMI/FIQ shortly after 3.17rc1 comes
out.

--
1.9.3

From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 30 Oct 2013 15:44:39 -0400
Subject: [PATCH v2 0/2] cpufreq support for the big.LITTLE switcher
Message-ID: <1383162281-24204-1-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the third and final set of patches towards a fully functional
and production quality switcher solution for big.LITTLE systems,
establishing a landmark to compare against for any scheduler based
solution meant to eventually surpass the switcher's power efficiency
available in the mainline kernel.

Rationale for this code: http://lwn.net/Articles/481055/

The first and second patch sets have already been merged by RMK.  They
implement the core switcher mechanism.  This set adds the necessary code
to drive the switcher based on cpufreq governor decisions.

This set (v2) was rebased on top of the latest linux-pm tree as
requested by Rafael.

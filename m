From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 30 Oct 2013 22:52:49 +0100
Subject: [PATCH v2 0/2] cpufreq support for the big.LITTLE switcher
In-Reply-To: <1383162281-24204-1-git-send-email-nicolas.pitre@linaro.org>
References: <1383162281-24204-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <7822477.lBueQHUY4E@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, October 30, 2013 03:44:39 PM Nicolas Pitre wrote:
> This is the third and final set of patches towards a fully functional
> and production quality switcher solution for big.LITTLE systems,
> establishing a landmark to compare against for any scheduler based
> solution meant to eventually surpass the switcher's power efficiency
> available in the mainline kernel.
> 
> Rationale for this code: http://lwn.net/Articles/481055/
> 
> The first and second patch sets have already been merged by RMK.  They
> implement the core switcher mechanism.  This set adds the necessary code
> to drive the switcher based on cpufreq governor decisions.
> 
> This set (v2) was rebased on top of the latest linux-pm tree as
> requested by Rafael.

Queued up for 3.13, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

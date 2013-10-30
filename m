From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 30 Oct 2013 15:01:05 +0100
Subject: [PATCH 0/2] cpufreq support for the big.LITTLE switcher
In-Reply-To: <1382500691-634-1-git-send-email-nicolas.pitre@linaro.org>
References: <1382500691-634-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <5107459.zGbYpZKUI5@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, October 22, 2013 11:58:09 PM Nicolas Pitre wrote:
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

Patch [1/2] doesn't apply any more after all of the recent changes from Viresh.

Please rebase on top of linux-pm/linux-next and resend.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

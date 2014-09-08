From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Sep 2014 17:24:49 +0100
Subject: [PATCH v3 0/5] arm: Implement arch_trigger_all_cpu_backtrace
In-Reply-To: <1410190115-32604-1-git-send-email-daniel.thompson@linaro.org>
References: <1409931198-22600-1-git-send-email-daniel.thompson@linaro.org>
 <1410190115-32604-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140908162449.GD12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 04:28:30PM +0100, Daniel Thompson wrote:
> * Restructured to sit nicely on a similar FYI patchset from Russell
>   King. It now effectively replaces the work in progress final patch
>   with something much more complete.

I'd suggest that patch 2 should be in a different place - get the FIQ
infrastructure in place first before adding any users of it would be
a much more sensible patch ordering.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.

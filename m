From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Sat, 30 Nov 2013 15:28:02 +0200
Subject: [RFC 4/4] ASoC: RX-51: Add DT support to sound driver
In-Reply-To: <20131106143248.GD15551@amd.pavel.ucw.cz>
References: <1382909086-10493-1-git-send-email-sre@debian.org>
 <1382909086-10493-5-git-send-email-sre@debian.org>
 <20131106143248.GD15551@amd.pavel.ucw.cz>
Message-ID: <5299E7E2.8040206@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 11/06/2013 04:32 PM, Pavel Machek wrote:
> Hi!
> 
>> This patch adds device tree support to the Nokia N900 audio driver.
> 
> Note, N900 audio driver.
> 
>> +- compatible: "nokia,rx51-audio"
> 
> Still, it is rx51-audio. If it is feasible, could we move away from
> rx51 naming and into n900 naming that is familiar to mere humans?
> 
> We can rename the sources later, but I guess we should get dts binding
> right first time...

Sorry the long response. I definitely would like n900 naming more in dts.

History is that the basic board file for N900 went to mainline before
sales started and used the hw name in sources and Kconfig. Audio machine
driver then followed the same rx51 hw naming scheme with rest of sources.

-- 
Jarkko

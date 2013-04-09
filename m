From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 09 Apr 2013 09:38:05 -0600
Subject: [GIT PULL 5/8] ARM: tegra: clock driver development
In-Reply-To: <201304091714.53220.arnd@arndb.de>
References: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
 <1365181426-11547-5-git-send-email-swarren@wwwdotorg.org>
 <201304091714.53220.arnd@arndb.de>
Message-ID: <516435DD.6060006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2013 09:14 AM, Arnd Bergmann wrote:
> On Friday 05 April 2013, Stephen Warren wrote:
>> This branch contains most fixes and enhancements to the Tegra common
>> clock driver. The main new feature is a driver for Tegra114, which
>> coupled with later device tree changes enables many devices on that
>> chip, such as MMC, I2C, etc.
>>
>> This branch depends on a patch in:
>>
>> git://git.linaro.org/people/mturquette/linux.git clk-for-3.10
> 
> Pulled into next/drivers branch, and noted down the dependency.
> 
> As a general recommendation, it is nicer if you can prepare a
> separate branch with the dependency, even if it's just one patch,
> and have that pulled into both maintainer trees, rather than
> having us add the entire set of clk changes as a dependency.

Yes, I did ask for that to happen repeatedly, but Mike forgot when
applying the patch to his tree.

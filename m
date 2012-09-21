From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 20 Sep 2012 19:08:59 -0600
Subject: [GIT PULL] ARM: add basic BCM2835 SoC and Raspberry Pi board
 support
In-Reply-To: <20120921002814.GA15296@quad.lixom.net>
References: <1348104718-21751-1-git-send-email-swarren@wwwdotorg.org>
 <20120921002814.GA15296@quad.lixom.net>
Message-ID: <505BBE2B.5050909@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2012 06:28 PM, Olof Johansson wrote:
> On Wed, Sep 19, 2012 at 07:31:58PM -0600, Stephen Warren wrote:
>> The BCM2835 is an ARM SoC from Broadcom. This patch adds very basic
>> support for this SoC; enough to boot the system into an initrd with
>> UART console, interrupt controller, timers, and a stub clock driver.
>>
>> Also provided is a similarly basic device tree for the Raspberry Pi
>> Model B board.
>>
>> This series was written by Simon Arlott, Chris Boot, and Dom Cobley
>> downstream, with reference to a Broadcom tree, and modified for upstream
>> and submitted by Stephen Warren.
>>
>> ----------------------------------------------------------------
>>
>> The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:
>>
>>   Linux 3.6-rc5
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git rpi-for-3.7
> 
> Nice!
> 
> I'm going to guess that you meant linux-rpi.git here since that's where I found
> a tag with the commit you're referencing in the pull request at the head. :)

Oops, and I even went to the trouble of editing my pull request script
to make that a parameter..., which I evidently forgot to pass.

From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 18 Oct 2013 16:42:27 -0600
Subject: [GIT PULL 3/6] ARM: tegra: core SoC support changes for 3.13
In-Reply-To: <87ppr3y01l.fsf@linaro.org>
References: <1382036881-23339-1-git-send-email-swarren@wwwdotorg.org>	<1382036881-23339-3-git-send-email-swarren@wwwdotorg.org>
 <87ppr3y01l.fsf@linaro.org>
Message-ID: <5261B953.5020403@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2013 05:01 PM, Kevin Hilman wrote:
> Stephen Warren <swarren@wwwdotorg.org> writes:
> 
>> This branch includes:
>> * SoC fuse values are used as device randomness at boot.
>> * Initial support for the Tegra124 SoC is added. When coupled with an
>>   appropriate clock driver, which should also be merged for 3.13, we are
>>   able to boot to user-space using an initrd.
>> * The powergate code gains support for Tegra114.
>>
>> This branch is based on previous pull request tegra-for-3.13-cleanup.
> 
> hmm, seems to actually be based on tegra-for-3.13-cleanup~1...

Oh, indeed.

...
> git figures it out and it all comes out in the wash when merging, but
> makes looking at the merge history slightly confusing and the
> dependencies not obvious.  
> 
> Any chance you can respin this branch on top of your cleanup branch that
> I pulled so the merge points/branches and dependencies are obvious?

I've rebased that branch and issued a v2.

On a side note, the Globalgig WiFi dongle I brought with me to Edinburgh
is really slow, and doesn't like OpenVPN and/or UDP at all:-(

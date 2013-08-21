From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 21 Aug 2013 09:57:03 -0600
Subject: [GIT PULL 3/4] ARM: tegra: device tree changes for 3.12
In-Reply-To: <8738q4j59d.fsf@kernel.org>
References: <1376673628-5867-1-git-send-email-swarren@wwwdotorg.org>
 <1376673628-5867-3-git-send-email-swarren@wwwdotorg.org>
 <8738q4j59d.fsf@kernel.org>
Message-ID: <5214E34F.2030606@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2013 05:45 PM, Kevin Hilman wrote:
> Stephen Warren <swarren@wwwdotorg.org> writes:
> 
>> This branch contains all *.dts (device tree) changes for Tegra.
>> New features enabled are:
>>
>> * PMICs on Dalmore
>> * CPU power-gating on Dalmore
>> * HDMI output on Beaver
>> * LP1 system suspend mode on almost all boards
>> * PCIe support on numerous Tegra20/30 boards
>> * USB support on Tegra30/114 boards
>> * Audio capture on Beaver and Dalmore
>> * Temperature sensor on Cardhu.
>>
>> ... along with a few DT cleanups.
> 
> Hmm, shouldn't I have a DT maintainer signoff on this stuff... oh,
> wait... ;)

One thought here on my DT binding maintainer role (hence CCing the other
DT maintainers):

I assume that the DT maintainers are reviewing the DT bindings, and not
the *.dts files. There's certainly so much email defining/modifying
bindings that I can't even keep up with that. So, I deliberately don't
even attempt to look at anything other than the binding changes. Is this
not what the role entails? If the role is supposed to include reviewing
*.dts changes, then perhaps I should wait until someone else has
reviewed such patches before applying them to the Tegra tree?

Of course, as Tegra maintainer I do actively look at the specific *.dts
changes that go through my own tree.

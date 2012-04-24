From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 24 Apr 2012 10:43:58 -0600
Subject: Tag on pinctrl
In-Reply-To: <CACRpkdYqZrNFxj4kyMqYZk5PAcjF6-TroJ+Xq+3EVBLvo5Zg-Q@mail.gmail.com>
References: <CACRpkdYqZrNFxj4kyMqYZk5PAcjF6-TroJ+Xq+3EVBLvo5Zg-Q@mail.gmail.com>
Message-ID: <4F96D84E.7080204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2012 07:15 AM, Linus Walleij wrote:
> A while back I created a tag:
> 
> pinctrl-mergebase-20120418
> 
> On the pinctrl tree. It contains stuff up until that date that
> has since been sitting in linux-next for a while.
> 
> I do not expect to rebase these patches further. They
> are based on v3.4-rc3. So I will base any further pinctrl
> work on this.
> 
> I think Stephen needed to pull this into the ARM SoC tree?

Yes, I have pulled that tag into the Tegra tree as
for-3.5/gpio-pinmux-dependency, and have a Tegra-specific
for-3.5/gpio-pinmux branch that depends on it. Two other Tegra branches
in turn (for-3.5/tegra30-audio, for-3.5/usb-ulpi) depend on
for-3.5/gpio-pinmux.

Linus, I think this will get into the ARM SoC tree simply by my saying
in my for-3.5/gpio-pinmux pull request that the branch depends on your
tag; I don't /think/ you need to explicitly send a pull request there,
right?

From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 12 May 2012 22:21:59 -0600
Subject: Stable I2C branch needed as a dependency for Tegra change
In-Reply-To: <20120512184515.GC28973@pengutronix.de>
References: <4FA31297.8000904@wwwdotorg.org>
 <20120512184515.GC28973@pengutronix.de>
Message-ID: <4FAF36E7.1070104@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2012 12:45 PM, Wolfram Sang wrote:
> Hi,
> 
>> Is your i2c-embedded/for-next branch stable (i.e. that commit
>> will not be rebased between now and when you send a pull request
>> for 3.5), so I can use it as a baseline for a Tegra branch? If
>> not, could you let me know when it is stable, so I can create the
>> Tegra branch as that time.
> 
> Because of my holidays coming along, I'd think my for-next branch
> is done now (except for additions maybe). Yet, when and how to
> rewind the branch and/or offering a stable base in general is
> another thing I need to scratch my head about afterwards.

No worries then; I'll hold the dependent patch until 3.6; that way
there won't be any specific dependencies.

From: olof@lixom.net (Olof Johansson)
Date: Thu, 31 Jan 2013 20:35:49 -0800
Subject: [GIT PULL 5/8] ARM: tegra: SCU base rework
In-Reply-To: <20130201043222.GC5844@quad.lixom.net>
References: <1359582159-28816-1-git-send-email-swarren@wwwdotorg.org>
 <1359582159-28816-5-git-send-email-swarren@wwwdotorg.org>
 <20130201043222.GC5844@quad.lixom.net>
Message-ID: <CAOesGMjjgz7Am7-D_fQHqgLX=G+Wc_LKL-GYMHd1-NzVC-DUfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 8:32 PM, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Jan 30, 2013 at 02:42:36PM -0700, Stephen Warren wrote:
>> Tegra currently relies on the SCU to determine the number of CPU
>> cores, and also hard-codes the SCU physical address.
>>
>> This series adds a /cpus node to the Tegra device tree, and updates
>> the code to rely solely on that to determine the CPU count. A new
>> API is introduced to query for the existence of SCU registers, and the
>> SCU register address. Tegra and OMAP2 are converted to use these new
>> APIs.
>>
>> This pull request is based on a merge of v3.8-rc3, and arm-soc's
>> depends/rmk-perf branch.
>
> This one looks like it should also be based on your cleanup, since it has
> conflicts with it. Please rebase accordingly.

By the way, just in case this looks like a random request...

A few merge conflicts between independent topic branches is not a big
deal; we can deal with those.

What's somewhat annoying though, is when a previous cleanup branch
conflicts with later features. So, please base features on top of
cleanups accordingly.


Thanks,

-Olof

From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 16 Oct 2013 08:04:43 -0700
Subject: pull request for tegra clocks (resend with some CCs added this
 time)
In-Reply-To: <525D6276.1030507@wwwdotorg.org>
References: <20131015153620.GA12721@tbergstrom-lnx.Nvidia.com>
 <525D6276.1030507@wwwdotorg.org>
Message-ID: <CAPtuhTg5VTqzzoz1kMPx7tzFzW6gjJx+BNnrqmjaG0UR_OH+xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm happy for the changes to be based on an -rc or clk-next. Either is fine.

Thanks,
Mike

On Tue, Oct 15, 2013 at 8:42 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 10/15/2013 09:36 AM, Peter De Schrijver wrote:
>> The following changes since commit a0cf1abc25ac197dd97b857c0f6341066a8cb1cf:
>>
>>   Add linux-next specific files for 20130927 (2013-09-27 18:48:50 +1000)
>>
>> are available in the git repository at:
>>   git://nv-tegra.nvidia.com/user/pdeschrijver/linux.git tegra-clk-patches-0
>
> ??? That won't merge into Mike's tree correctly. The pull request should
> be based on a -rc or final release in the Linus tree, e.g. based on
> v3.12-rc1. Otherwise, if Mike merges this, it will pull in all patches
> from other subsystems that went into linux-next.

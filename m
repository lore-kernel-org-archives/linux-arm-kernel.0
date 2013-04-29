From: agraf@suse.de (Alexander Graf)
Date: Mon, 29 Apr 2013 14:53:58 +0200
Subject: [PATCH 0/2] Early printk support for virtio console devices.
In-Reply-To: <CAFEAcA-qfbMWD4fxLSN5uiBzO4fjqpwnx5pZd2QY=6Q=+dMNPw@mail.gmail.com>
References: <1366974299-17877-1-git-send-email-pranavkumar@linaro.org>
 <BA2076A6-0688-4E5C-85F9-A9CA8FD75782@suse.de>
 <87obcyc9sh.fsf@rustcorp.com.au>
 <336C59AA-D5D7-472E-A8DA-EEB413DD6C68@suse.de>
 <CAFEAcA-qfbMWD4fxLSN5uiBzO4fjqpwnx5pZd2QY=6Q=+dMNPw@mail.gmail.com>
Message-ID: <9DCAE29E-A113-4E74-A663-1AB224AD97E0@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 29.04.2013, at 14:50, Peter Maydell wrote:

> On 29 April 2013 13:22, Alexander Graf <agraf@suse.de> wrote:
>> Oh, and it should default to off.
> 
> That would be a pretty unhelpful default. We should default
> things so that console output from the kernel is available
> as early as reasonably possible by default IMHO -- this
> reduces the number of "nothing happens" user complaints
> where you then have to explain how to enable early printk
> so you can get some actual information about what happened.

Users complaining that they only see half of their kernel log are even worse IMHO :)


Alex

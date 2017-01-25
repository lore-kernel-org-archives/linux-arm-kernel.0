From: labbott@redhat.com (Laura Abbott)
Date: Wed, 25 Jan 2017 12:25:03 +0100
Subject: [PATCH 1/2] security: Change name of CONFIG_DEBUG_RODATA
In-Reply-To: <20170119105646.GA11176@leverpostej>
References: <1484789346-21012-1-git-send-email-labbott@redhat.com>
 <1484789346-21012-2-git-send-email-labbott@redhat.com>
 <20170119105646.GA11176@leverpostej>
Message-ID: <4116b91a-4fb5-414d-5fd5-36be151c600c@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2017 11:56 AM, Mark Rutland wrote:
> Hi Laura,
>
> On Wed, Jan 18, 2017 at 05:29:05PM -0800, Laura Abbott wrote:
>>
>> Despite the word 'debug' in CONFIG_DEBUG_RODATA, this kernel option
>> provides key security features that are to be expected on a modern
>> system. Change the name to CONFIG_HARDENED_PAGE_MAPPINGS which more
>> accurately describes what this option is intended to do.
>
> This generally sounds good. Thanks for attacking this!
>
> On the bikeshedding front, *maybe* it would be nice to mention
> permissions in the name, something like STRICT_KERNEL_RWX. That might
> also prevent the reading of 'hardened' as 'optional overhead'.
>
> That said, the proposed name is fine by me -- I'm happy so long as
> 'DEBUG' goes.
>

(Apologies for the delay, my SMTP was set up incorrectly so my
messages didn't actually get sent out)

I like that better since it's describing specifically what the config
should be setting as opposed to something more vague. That might fit
better with what Pavel was suggesting as well.

Thanks,
Laura

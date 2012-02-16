From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 16 Feb 2012 08:05:39 +0800
Subject: Possible circular locking dependency (3.3-rc2)
In-Reply-To: <20120215200731.GD25779@ponder.secretlab.ca>
References: <20120208124147.GF16334@legolas.emea.dhcp.ti.com>
 <CACVXFVMfmabcH57da-prx=J950KEoFtfb-zsuBWn7VY3NaMUUQ@mail.gmail.com>
 <CACRpkdZ7bs=i6Zg1ckXk-xBhY9z5VbvhVMk7p2_kP-=eB2bCKw@mail.gmail.com>
 <20120215200731.GD25779@ponder.secretlab.ca>
Message-ID: <CACVXFVNsRuvs91dw0YuvJkFCqc_kNjoBc17wsAo7yOPo0kfSag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 4:07 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Wed, Feb 15, 2012 at 07:54:56PM +0100, Linus Walleij wrote:
>> On Mon, Feb 13, 2012 at 3:53 PM, Ming Lei <tom.leiming@gmail.com> wrote:
>>
>> > Looks 'sysfs_lock' needn't to be held for unregister, so the patch below may
>> > fix the problem.
>>
>> Looks correct to me!
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Ming, can I have a proper Signed-off-by: line from you so I can apply this
> patch?

Sure, :-)

thanks
-- 
Ming Lei

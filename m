From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Sat, 13 Sep 2014 15:34:17 -0700
Subject: [PATCH] arm: add missing exports for asm functions required by
 get_user macro
In-Reply-To: <20140913220057.GT12361@n2100.arm.linux.org.uk>
References: <1410637161-4865-1-git-send-email-victor.kamensky@linaro.org>
 <1410637161-4865-2-git-send-email-victor.kamensky@linaro.org>
 <20140913220057.GT12361@n2100.arm.linux.org.uk>
Message-ID: <CAA3XUr0kauAcrP7HA5N+BZbqWbmWvMPy_6OPRUJfUDvZgz7yFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 September 2014 15:00, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Sep 13, 2014 at 12:39:21PM -0700, Victor Kamensky wrote:
>> Previous commits that dealt with get_user for 64bit type missed to
>> export proper functions, so if get_user macro with particular target/value
>> types are used by kernel module modpost would produce 'undefined!' error.
>> Solution is to export all required functions.
>>
>> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
>
> Patch looks good on its own, please send to the patch system.

Submitted as
   http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8151/1

> I can either apply it as a follow on patch, or I can merge it into your
> original patch.  Which would you prefer?

Either way is fine with me, whatever easier for you.

Thanks,
Victor

> --
> FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
> according to speedtest.net.

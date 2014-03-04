From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 04 Mar 2014 11:32:50 +0100
Subject: [PATCH v2 1/5] ASoC: kirkwood: prepare new Dove DT Kconfig
 variable
In-Reply-To: <20140304040314.GC2411@sirena.org.uk>
References: <1393536486-3827-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393662801-17950-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140304040314.GC2411@sirena.org.uk>
Message-ID: <5315ABD2.9030809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2014 05:03 AM, Mark Brown wrote:
> On Sat, Mar 01, 2014 at 09:33:17AM +0100, Sebastian Hesselbarth wrote:
>> DT-enabled Dove will move over from ARCH_DOVE in mach-dove to MACH_DOVE in
>> mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
>> DT-only MACH_DOVE Kconfig.
>
> This doesn't apply against current ASoC, please check and resend.

Mark,

actually looking at what that specific Kconfig will look like in
asoc/for-next, I guess the current version is sufficient already.

It already says:

depends on ARCH_KIRKWOOD || ARCH_DOVE || ARCH_MVEBU || COMPILE_TEST

and MACH_DOVE will be part of ARCH_MVEBU.

Thanks for pointing this out, please ignore this patch.

Sebastian

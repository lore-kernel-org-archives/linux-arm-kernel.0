From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 15 Nov 2013 18:09:50 +0100
Subject: [RFC DTC PATCH] dtc: add symlink (-L) output to dtbs
In-Reply-To: <20131115152336.GD10335@titan.lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <52814AFB.3070600@wwwdotorg.org>
 <CAL_Jsq+mAoN2Lbg+uqfLMTZBvgz28E-EioiaU4BUSL_7rS5JjA@mail.gmail.com>
 <528275B7.6050209@wwwdotorg.org>
 <20131112193012.GR10335@titan.lakedaemon.net>
 <52828C77.20001@wwwdotorg.org>
 <20131114162859.GX10335@titan.lakedaemon.net>
 <20131114192629.GE16735@n2100.arm.linux.org.uk>
 <20131115152336.GD10335@titan.lakedaemon.net>
Message-ID: <CABxcv==rgF8fHL0MBStEsE6WmFs4OyQvuuyPQU4tqXG2NoDrzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Fri, Nov 15, 2013 at 4:23 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Thu, Nov 14, 2013 at 07:26:29PM +0000, Russell King - ARM Linux wrote:
>> We have ways and means to deal with the installation of kernel images
>> and modules.  There's well defined makefile targets for this, and
>> make variables which control where and how these get put.  For the
>> kernel image, you can specify the script to be run (which is called
>> with the location of the *Image file) for copying.  Pulling it manually
>> out of arch/arm/boot is really a failure of the distro packaging people
>> to get their process right.
>>
>> The same goes for the DT files: if we don't provide a method for the
>> kernel build system to install these in a sane way, then that's our
>> failing.  However, distros should be asking for this, and not picking
>> the files out of arch/arm/boot/dts.
>
> Exactly.  V2 hopefully this weekend implementing 'make dtbs-install'

Just a small comment, I think the make target should be called
'dtbs_install and not of 'dtbs-install' to be consistent with make
{modules,firmware,headers}_install

>
> thx,
>
> Jason.
>

Best regards,
Javier

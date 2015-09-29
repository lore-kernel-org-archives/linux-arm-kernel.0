From: jwboyer@fedoraproject.org (Josh Boyer)
Date: Tue, 29 Sep 2015 10:32:59 -0400
Subject: [PATCH RESEND] ARM: dts: Fix Makefile target for
 sun4i-a10-itead-iteaduino-plus
In-Reply-To: <20150906112046.GK31584@lukather>
References: <20150904124934.GD464@hansolo.redhat.com>
 <20150906112046.GK31584@lukather>
Message-ID: <CA+5PVA5ceg94PrUdUpb5X7ZsbEuK4_u1V-ZDesR7h_MZ8rGUtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 6, 2015 at 7:20 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Sep 04, 2015 at 08:49:34AM -0400, Josh Boyer wrote:
>> Commit 79ae3e66f8d (ARM: dts: sun4i: Add Iteaduino Plus A10) added a new
>> make target for the sun4i-a10-itead-iteaduino-plus dts file, but mistakenly
>> used .dts instead of the correct .dtb suffix.  This resulted in a build error
>> like:
>>
>>         scripts/Makefile.dtbinst:42: target 'sun4i-a10-itead-iteaduino-plus.dts' doesn't match the target pattern
>>
>> when doing a make dtbs_install.
>>
>> Fix it to use the proper file name.
>>
>> Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
>
> Queued, thanks!

Are you going to push this to Olof or Linus for the 4.3 release?  I
don't see it in Linus' tree and this is still broken there.

josh

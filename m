From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 21 Oct 2010 16:26:19 +0200
Subject: [patch v2 07/10] efikamx: add support for power key
In-Reply-To: <87wrpbhe5l.fsf@lechat.rtp-net.org> (Arnaud Patard's message of
	"Thu\, 21 Oct 2010 15\:24\:38 +0200")
References: <20101021103855.115653951@rtp-net.org>
	<20101021104005.796793454@rtp-net.org>
	<AANLkTimWHeibb47NfQ7UJoawi5QN2gt1FjpvKy0S82LH@mail.gmail.com>
	<87wrpbhe5l.fsf@lechat.rtp-net.org>
Message-ID: <87sjzzhbas.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org> writes:

> Fabio Estevam <festevam@gmail.com> writes:
>
>> Hi Arnaud,
>
> Hi,
>
>>
>> On Thu, Oct 21, 2010 at 8:39 AM, Arnaud Patard
>> <arnaud.patard@rtp-net.org> wrote:
>>> This patch adds support for power key button of the efika mx. It's connected
>>> on ?GPIO 3 31.
>>
>> Here you mention GPIO 3 31
>>
>>> +#define EFIKAMX_POWER_KEY ? ? ?(1*32 + 31)
>>
>> ,but here you define it as GPIO 2 31
>
> It's a typo in the patch description [ I wouldn't have sent the patch if
> it was not working :) ]. The reset is on 2 31.
>

oops. s/reset is on 2 31/power key is on 2 31/ sorry for the confusion :(

Arnaud

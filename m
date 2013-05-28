From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 28 May 2013 12:15:04 +0200
Subject: [PATCHv2 0/3] Add G762/G763 PWM fan controller
References: <cover.1369687670.git.arno@natisbad.org>
 <152190814.eApXVbVBPA@wuerfel>
Message-ID: <87li6z2yxj.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> writes:

> On Tuesday 28 May 2013 00:02:29 Arnaud Ebalard wrote:
>> 
>> This series adds support for GMT G762/G763. This work is based on a
>> basic version for 2.6.31 kernel developed Olivier Mouchet for LaCie
>> NAS. Updates have been performed to run on recent kernels. Support has
>> been completed and additional features added: ability to configure
>> various characteristics from .dts file, better initialization, alarms
>> and error reporting support, gear mode, polarity, fan pulse per
>> revolution, fan startup voltage control.
>
> I wonder if this could be split into two separate drivers, one for
> the pwm subsystem, and one for a hardware-independent fan controller
> based on the pwm interfaces.

To be honest, I wouldn't even know how to start in order to do that.
Additionally, it would be worth the effort if other drivers could be
easily refactored using this idea. I'll let hwmon people provide some
feedback and try and comply with their directions (based on the cpu
cycle I can spend on this).

Cheers,

a+

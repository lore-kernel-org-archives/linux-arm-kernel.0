From: olof@lixom.net (Olof Johansson)
Date: Thu, 31 Dec 2015 17:31:57 +0100
Subject: [PATCH RFC] ARM: tango4: Fix build issues
In-Reply-To: <20151231132116.GB1547@localhost>
References: <567DBA04.4060709@free.fr>
	<20151231132116.GB1547@localhost>
Message-ID: <CAOesGMhBkacNRxQaBKG8f5Bv2FXH504YCj_O0eL=FwGzY03H-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 31, 2015 at 2:21 PM, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Dec 25, 2015 at 10:49:56PM +0100, Mason wrote:
>> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>>
>> Move SMP setup to platsmp.c
>> Specify the CPU type to the assembler, and only for smc.S
>>
>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>> ---
>
> Applied, thanks.

Actually, I just noticed that the smc.c Makefile part isn't done as it
should, so I'll drop this again.


-Olof

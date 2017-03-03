From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sat, 4 Mar 2017 00:28:32 +0100
Subject: [PATCH v2 09/17] Documentation: kernel-parameters: Document owl
 earlycon
In-Reply-To: <20170303154650.4d959227@lwn.net>
References: <20170224034055.18807-1-afaerber@suse.de>
 <20170224034055.18807-10-afaerber@suse.de> <20170303154650.4d959227@lwn.net>
Message-ID: <fc0061fe-c680-e8d7-9d45-583c2ae43ff2@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 03.03.2017 um 23:46 schrieb Jonathan Corbet:
> On Fri, 24 Feb 2017 04:40:47 +0100
> Andreas F?rber <afaerber@suse.de> wrote:
> 
>> +		owl,<addr>
>> +			Start an early, polled-mode console on an Owl serial
>> +			port at the specified address. The serial port must
>> +			already be setup and configured. Options are not yet
>> +			supported.
>> +
> 
> Apologies, I'm just getting around to looking at this.
> 
> Is there any chance of getting a version of it that (1) has a proper
> changelog, and (2) better describes the applicability of this option.
> Presumably if I don't know what an "Owl serial port" is I don't need it,
> but maybe a phrase saying where such ports might be found would be helpful
> here?

Note that there is already a v3 of this patch.

Both v2 and v3 do have a changelog, indicating that nothing changed here
between versions. Did you mean commit message, and if so what would you
like to see added exactly?

Did you notice that most earlycon options are described like this?
pl011, my meson, msm, lantiq all just repeat the driver name. In this
case Owl is a family of Actions Semiconductor SoCs that are newly being
enabled in this series - I can add the vendor name to the text, but no
idea what else to say about "applicability"...

While at it, it is really ugly for both users and contributors that
there is no consistent (e.g., alphabetical) order of these options.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)

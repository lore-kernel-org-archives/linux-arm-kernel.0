From: khilman@ti.com (Kevin Hilman)
Date: Fri, 09 Sep 2011 14:48:54 -0700
Subject: [PATCH 11/22] OMAP4: powerdomain data: add voltage domains
In-Reply-To: <CAORVsuVikEPsk=1v_Mcevsu1iyDDQzdHuuKbBJUMRGL5mrLpXg@mail.gmail.com>
	(Jean Pihet's message of "Wed, 7 Sep 2011 11:04:26 +0200")
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
	<1314639355-12713-12-git-send-email-khilman@ti.com>
	<CAORVsuVikEPsk=1v_Mcevsu1iyDDQzdHuuKbBJUMRGL5mrLpXg@mail.gmail.com>
Message-ID: <871uvptmih.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Hi,
>
> On Mon, Aug 29, 2011 at 7:35 PM, Kevin Hilman <khilman@ti.com> wrote:
>> From: Benoit Cousson <b-cousson@ti.com>
>>
>> Add voltage domain name to indicate which voltagedomain each
>> powerdomain is in.
>>
>> The fixed voltage domain like ldo_wakeup for emu and wkup power
>> domain is added too.
>>
>> Update the TI copyright date to 2011.
> This seems to not be part of this patch.

OK, dropping this part of the changelog.  The new stuff (voltagedomain data)
already has a 2011 copyright, and I'll just leave the powerdomain stuff
for now.

> Ok for the rest of it.

Thanks for the review.

Kevin

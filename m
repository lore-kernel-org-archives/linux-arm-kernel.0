From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Fri, 10 Apr 2015 21:22:23 +0100
Subject: [PATCH] ARM: dts: am437x-gp-evm: add DT nodes for ov2659 sensor
In-Reply-To: <20150317022344.GB31346@atomide.com>
References: <1426203501-32115-1-git-send-email-prabhakar.csengg@gmail.com>
 <20150316221740.GQ12397@atomide.com>
 <CA+V-a8uWqjze32ukOGonQAACByPmW6WDbpFrA9EFipnNJeD58A@mail.gmail.com>
 <20150317022344.GB31346@atomide.com>
Message-ID: <CA+V-a8u-Y7M9ynJDD05=XeMjZMsb_0Utd-TuwJzEuRziPksvGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Tue, Mar 17, 2015 at 2:23 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Lad, Prabhakar <prabhakar.csengg@gmail.com> [150316 18:20]:
>> Hi Tony,
>>
>> On Mon, Mar 16, 2015 at 10:17 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Lad Prabhakar <prabhakar.csengg@gmail.com> [150312 16:38]:
>> >> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>> >>
>> >> this patch does the following:
>> >> 1: adds DT node for fixed oscillator.
>> >> 2: adds DT node entries for ov2659 sensor
>> >> 3: adds remote-endpoint entry for VPFE.
>> >>
>> >> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>> >
>> > Applying into omap-for-v4.1/dt thanks.
>> >
>> I would like to get this one in via media tree to avoid dependency
>> as I am still waiting for Acks from DT maintainers for the sensor
>> driver.
>
> OK dropping it.
>
>> If I can get your Ack on this I'll queue it up along with sensor
>> driver via media tree.
>
> Sorry the chances are too big for pointless merge conflicts with
> these files with constant patching going on.
>
> Please just resend this patch alone again to me later on once the
> driver changes are merged into Linux next and on their way to the
> mainline kernel.
>
the sensor driver is now present in linux-next and the same patch
applies cleanly, can you pick up the same or do you want me to
resend the patch ?

Cheers,
--Prabhakar Lad

From: simran.rai@broadcom.com (Simran Rai)
Date: Thu, 31 Mar 2016 11:14:53 -0700
Subject: [PATCH resend v5 1/3] ASoC: cygnus: Add DT bindings for Broadcom
 Cygnus audio
In-Reply-To: <20160331141308.GA9670@rob-hp-laptop>
References: <1459277192-10942-1-git-send-email-simran.rai@broadcom.com>
 <1459277192-10942-2-git-send-email-simran.rai@broadcom.com>
 <20160331141308.GA9670@rob-hp-laptop>
Message-ID: <CAES42Na+wM6P5yB3tg+bxk88txQA+52kgL8uwFqEW1XO8LfUeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Thu, Mar 31, 2016 at 7:13 AM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Mar 29, 2016 at 11:46:30AM -0700, Simran Rai wrote:
>> From: Simran Rai <ssimran@broadcom.com>
>>
>> Add bindings for audio driver in Broadcom Cygnus.
>>
>> Signed-off-by: Lori Hikichi <lhikichi@broadcom.com>
>> Signed-off-by: Simran Rai <ssimran@broadcom.com>
>> Reviewed-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> Signed-off-by: Simran Rai <simran.rai@broadcom.com>
>> ---
>>  .../bindings/sound/brcm,cygnus-audio.txt           |   67 ++++++++++++++++++++
>>  1 file changed, 67 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
>
> I acked v3 of this already. Did something change? If not, please add
> acks when sending new versions. If things did change, explain that here.
There was a change made in v4 that introduced assigned-clocks,
assigned-clock-parents, and assigned-clock-rates, to allow initial
configuration of
default parent clock and its frequency.
>
> And this v5 is not a resend if you didn't already send out v5 before.
I had sent out v5 on March 01 but looks like it did not make it to
through. Yesterday I sent out another patch (v6) to address Mark's
comments. Can you please ack PATCH v6.

Thanks,
Simran

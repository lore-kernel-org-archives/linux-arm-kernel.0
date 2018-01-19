From: mail@maciej.szmigiero.name (Maciej S. Szmigiero)
Date: Fri, 19 Jan 2018 14:38:46 +0100
Subject: [PATCH] ARM: dts: imx6qdl-udoo: Disable usbh1 to avoid kernel hang
In-Reply-To: <CAOMZO5DQ9T_003gzq-0Q-HrUEhzoZOHd-647DkUCQP9ka9ti4w@mail.gmail.com>
References: <1516278858-15464-1-git-send-email-fabio.estevam@nxp.com>
 <84391569-cdb9-1c17-7e37-6fdad954d549@maciej.szmigiero.name>
 <CAOMZO5DQ9T_003gzq-0Q-HrUEhzoZOHd-647DkUCQP9ka9ti4w@mail.gmail.com>
Message-ID: <0006d513-3ab5-d2b6-1caa-5d480dfadfaf@maciej.szmigiero.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.01.2018 12:59, Fabio Estevam wrote:
> Hi Maciej,
> 
> On Thu, Jan 18, 2018 at 9:11 PM, Maciej S. Szmigiero
> <mail@maciej.szmigiero.name> wrote:
> 
>> Hmm, did you get reports or checked that it actually hangs?
> 
> Both :-)
> 
>>
>> As far as I remember last time I ran a kernel without Peter's power
>> sequence library on this board it only wasn't able to communicate with
>> the on-board USB hub (and devices behind it), but besides this was
>> able to boot successfully.
>> But my memory may be wrong since it was some time ago.
> 
> Currently we are not able to reach the prompt without this patch as
> the system hangs.
> 

Okay, then:
Acked-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

@Peter:
If you are going to submit your power sequence library once again could
you please add this patch reversion to your UDOO DT changes in that
series for completeness?

Maciej

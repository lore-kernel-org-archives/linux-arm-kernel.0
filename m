From: keshava_mgowda@ti.com (Munegowda, Keshava)
Date: Mon, 25 Jun 2012 14:25:47 +0530
Subject: [PATCH 04/11] mfd: omap-usb: add clk_prepare and clk_unprepare
In-Reply-To: <alpine.DEB.2.00.1206221302470.10198@utopia.booyaka.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1340372890-10091-5-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1206221302470.10198@utopia.booyaka.com>
Message-ID: <CAP05o4L5r46UV3yte-iH1Qh7yA=dggjjHmeHvQTyURg31mo6Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 23, 2012 at 12:34 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Fri, 22 Jun 2012, Rajendra Nayak wrote:
>
>> In preparation of OMAP moving to Common Clk Framework (CCF) add clk_prepare()
>> and clk_unprepare() for the various usb host clocks.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>
> Looks like this one will be at least partially obsoleted by this series:
>

Thanks paul
Hi Rajendra
         please re-base this patch to below series:

> ARM: OMAP: TLL driver implementation for USB host driver
> http://marc.info/?l=linux-omap&m=134019432606399&w=2
>
> and the runtime PM conversion in that series needs to be done anyway.
>
>
> - Paul

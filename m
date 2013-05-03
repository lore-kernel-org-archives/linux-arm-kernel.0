From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 23:04:43 +0200
Subject: [PATCH 16/63] ARM: ux500: Remove superfluous 'psize' attribute
 from Audio platform data
In-Reply-To: <20130503205934.GA20194@balto.lan>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-17-git-send-email-lee.jones@linaro.org>
 <CACRpkdYPDnvb+_TEf63NsW8ra0ciWAHmp-VHiXPumFJbL=PNXg@mail.gmail.com>
 <20130503205934.GA20194@balto.lan>
Message-ID: <CACRpkdaCtG2B-hJpNGHv=dd9=t+9SqUrQa1OWO3A727otVfuKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 10:59 PM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:
> Hi Linus,
> On Fri, May 03, 2013 at 10:13:22PM +0200, Linus Walleij wrote:
>> On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>> > 'psize' is used to calculate the maximum DMA burst size. However it
>> > is only taken into consideration when editing the DMA channel's
>> > configuration. The Audio DMA platform data is only used to allocate
>> > a channel, not configure it. That will be done at a later date within
>> > the MSP driver.
>> >
>> > We're also removing comments which are no longer required, as
>> > 'data_width' is no longer set in any device's platform data period.
>> >
>> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>
>> Patch applied.
>>
>> Fabio: as I know you have audio working on the ux500
>> with the mainline driver: could you confirm that this patch
>> does not disturb the audio playback and provide a
>> Tested-by?
>
> Sure, I applied just this patch and it still works fine, tested on HREF
> with speaker-test.
> I have another non-related hack on dmaengine applied though, but Lee is
> already aware of it so this is good for me:
>
> Tested-by: Fabio Baltieri <fabio.baltieri@linaro.org>

Thanks! Much appreciated!

Yours,
Linus Walleij

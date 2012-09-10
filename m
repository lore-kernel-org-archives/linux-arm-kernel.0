From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 10 Sep 2012 11:21:34 +0300
Subject: [alsa-devel] [RFC update 0/2] dmaengine/ASoC: omap: Enable element
 mode in cyclic DMA
In-Reply-To: <1402174.PkzhGH5Vno@acer>
References: <E1T8a09-0002vz-Bl@rmk-PC.arm.linux.org.uk>
 <1346760482-12794-1-git-send-email-peter.ujfalusi@ti.com>
 <1402174.PkzhGH5Vno@acer>
Message-ID: <504DA30E.9030304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Janusz,

On 09/09/2012 10:57 PM, Janusz Krzysztofik wrote:
> On Tue, 4 Sep 2012 15:08:00 Peter Ujfalusi wrote:
>>
>> Enable the element mode (thus allowing mono playback and probably 
> unblocking
>> OMAP1, OMAP2420) in OMAP dmaengine and omap-pcm.
>>
>> Janusz: would it be possible for you to test Russell's series plus 
> this on
>> OMAP1 to make sure that we do not broke it?
> 
> Hi,
> I can confirm that sound works for me as before, both capture and 
> playback, on my OMAP1 Amstrad Delta with Russell's and Peter's patches 
> applied on top of linux-3.6-rc3, with the OMAP DMA engine driver built 
> in. I was not able make audible tests with applications other than a 
> soft phone as I didn't get back home for this weekend, but I think that 
> the asterisk soft phone is quite a demanding use case.

Thank you very much for taking time to test this! This is indeed a good news.

> The only thing I'm not sure about is why the sysfs provided 
> bytes_transferred values never change from their initial zeros.

I have not looked at those files in sysfs, but if the same applies for
OMAP3/4/5 I can look at it and fix it which should correct OMAP1 at the same time.

> 
> For OMAP1:
> Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Again, thanks for the testing,
P?ter

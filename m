From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 16 Feb 2012 18:34:26 +0100
Subject: remoteproc: Load coprocessor code to the specific main memory
 location
In-Reply-To: <4F3D032B.6090700@monstr.eu>
References: <4F1EE861.4030405@monstr.eu>
 <CAK=Wgba5kT8AwLtuHyosucYnWf-EA+xpE1kzmssfhSC7ZXQA=g@mail.gmail.com>
 <4F1FF870.3000105@monstr.eu>
 <CAK=WgbZwaxMPsMiNcq5yFvBLrcODqGgDT6b=mmQ91JBVtTEyXA@mail.gmail.com>
 <4F200F64.9060203@monstr.eu>
 <CAK=WgbZDADRf1OF=uWbbsF+t2dx36tqj=kRftn5nd4RA7DtEnA@mail.gmail.com>
 <4F212E9E.9060807@monstr.eu>
 <CAK=WgbYMBDp3Qm8TErNrnDwn2ZTFt62+OuyyQvVE-jrnNsL6kg@mail.gmail.com>
 <4F391C1D.9020402@monstr.eu>
 <CAK=WgbYn6hrS4YLEdfp=0jSEfEwy-HkJmt5S06_j6gZFf0UTmQ@mail.gmail.com>
 <4F3BA962.9040109@monstr.eu> <4F3BC30A.4030301@monstr.eu>
 <4F3CC899.4070302@monstr.eu>
 <CAK=WgbaRF-L7M3VMZQdqFLUFOJuwFVkBH1hUNuJ51kSrzkaVjA@mail.gmail.com>
 <4F3CFFAD.9030402@monstr.eu> <4F3D032B.6090700@monstr.eu>
Message-ID: <CAK=WgbZ3oXc+NQscdShqmu2wkzv=M-qBDCH2-k=5qSRX9W=z3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 2:22 PM, Michal Simek <monstr@monstr.eu> wrote:
> ok on that addresses above is mapped vring_desc structure. I expect that
> addr is address to any memory location when data are places. Next is filled
> by init because of ring buffer. What flags should be used? And what is data
> structure?

I'm sorry, but can you please rephrase this question too ? I'm just not
sure I understand you correctly.

In general, you don't need to fiddle with the vring_desc structure -
that's internal to virtio, and things should just work.

Or are you asking about the rtos side ?

Thanks,
Ohad.

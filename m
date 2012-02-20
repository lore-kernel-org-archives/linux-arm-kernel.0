From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 20 Feb 2012 22:11:53 +0200
Subject: remoteproc: Load coprocessor code to the specific main memory
 location
In-Reply-To: <4F425711.80102@monstr.eu>
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
 <CAK=WgbZ3oXc+NQscdShqmu2wkzv=M-qBDCH2-k=5qSRX9W=z3Q@mail.gmail.com>
 <CAHTX3dJ4PruKO-wJLJU8W0boHFL0f6eoF+QNaoNjm5hu26YEow@mail.gmail.com>
 <CAK=WgbZBJJbFcoeZ+hY=BgyW_4yvOJPVNMZ18_9o+zY7tEc_pQ@mail.gmail.com>
 <4F425711.80102@monstr.eu>
Message-ID: <CAK=WgbbNJMpndKqgW4SJjE=H-BqT7yVsB+F-kEfJWmW+ikJM+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On Mon, Feb 20, 2012 at 4:22 PM, Michal Simek <monstr@monstr.eu> wrote:
> IRC you mentioned somewhere that you maybe will have firmware which is
> possible to
> compiled by gcc and which doesn't required that TI tools. Am I correct or
> that was
> something totally different?

You're correct - this is in the works, but I'm afraid I don't have any
scheduling information about this, sorry.

But we have folks from another vendor now who got rpmsg working, and
are working out the legal issues so they can release the RTOS sources.
Hopefully that'll be released soon.

Thanks,
Ohad.

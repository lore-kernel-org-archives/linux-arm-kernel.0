From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 16 Feb 2012 18:27:34 +0100
Subject: remoteproc: Load coprocessor code to the specific main memory
 location
In-Reply-To: <4F3CFFAD.9030402@monstr.eu>
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
 <4F3CFFAD.9030402@monstr.eu>
Message-ID: <CAK=WgbbNaDGObazuLZODad6-O_8oJ5j=isS50gQ0DFefo+UW1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 2:07 PM, Michal Simek <monstr@monstr.eu> wrote:
> Above is condition "if (virtio_has_feature(vdev, VIRTIO_RPMSG_F_NS))" which
> is failing for me.

You might want to debug why.

For the dynamic channel creation to work, your rpmsg vdev should have
VIRTIO_RPMSG_F_NS. But that's part of the generic code, and you should
not bother about it - it should just work.

> How does look like that structure for vring channels? It is probably mapped
> any structure. Can you point me which one?

I'm sorry, can you please rephrase the question ? I'm not sure I'm following.

Thanks,
Ohad.

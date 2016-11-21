From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 21 Nov 2016 16:19:19 +0530
Subject: [PATCH v3 10/10] ARM: dts: da850: add usb device node
In-Reply-To: <c812d211-fff8-520f-cc1f-6fa69a765498@ti.com>
References: <20161107203948.28324-1-ahaslam@baylibre.com>
 <20161107203948.28324-11-ahaslam@baylibre.com>
 <48d0c158-f7c8-0d1e-f06e-b7b28d6f2b93@lechnology.com>
 <CAKXjFTN_VvxJ+mk=ooUiGqZJnuJJJn33KsBF2n6SvZNjWpYm3Q@mail.gmail.com>
 <c812d211-fff8-520f-cc1f-6fa69a765498@ti.com>
Message-ID: <e8bc1888-4936-7d8e-cf8a-a3f2b5644ef5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 November 2016 04:16 PM, Sekhar Nori wrote:
>>> In commit 2957e36e76c836b167e5e0c1edb578d8a9bd7af6 in the linux-davinci
>>> >> tree, the alias for the musb device is usb0. So, I think we should use usb1
>>> >> here instead of ohci - or change the usb0 alias to musb.
>>> >>
>>> >> https://git.kernel.org/cgit/linux/kernel/git/nsekhar/linux-davinci.git/commit/?h=v4.10/dt&id=2957e36e76c836b167e5e0c1edb578d8a9bd7af6
>> > 
>> > ok, i will change to usb1, since i will be resubmiting this.

> I have already applied a version of this patch. Please re-base against
> linux-davinci/master and send a delta patch.

Hmm, no. scratch that. I mixed this up with the musb patch I applied.
usb1 sounds good. Please also separate out the soc and board specific
dts additions for your next version.

Thanks,
Sekhar

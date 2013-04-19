From: pranavkumar@linaro.org (Pranavkumar Sawargaonkar)
Date: Fri, 19 Apr 2013 15:04:56 +0530
Subject: [RFC] arm64: Early printk support for virtio-mmio console devices.
In-Reply-To: <CAFEAcA8j124G=vaHObJ_w5wOhUiS3KYKbjMnigbnr6mgwFxZUg@mail.gmail.com>
References: <1366264344-28025-1-git-send-email-pranavkumar@linaro.org>
 <ede8ee08bb2616c2ed642200e3357367@localhost>
 <CAAHg+HhajHFC=1nh6YQNgpf=Na2FqcsYJ=t+ag9QiTg6TxUz9w@mail.gmail.com>
 <bb1193983de3ea9f4df1a570441df34c@localhost>
 <CAAHg+HhtCorArCmx=ha0=64+SJZiizzrDUKSPLV=N+OzO8zAxQ@mail.gmail.com>
 <20130419090558.GA13283@mudshark.cambridge.arm.com>
 <CAAHg+HipCX2ma6brxj9Kgc3ew39b5e30grLwyun9CViif-5wZQ@mail.gmail.com>
 <20130419092752.GB13283@mudshark.cambridge.arm.com>
 <CAFEAcA8j124G=vaHObJ_w5wOhUiS3KYKbjMnigbnr6mgwFxZUg@mail.gmail.com>
Message-ID: <CAAHg+Hg=t97SJ0JPZYgrZaL+zimo-wbezwaj1BQvHqE-vf4VDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 April 2013 15:00, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 19 April 2013 10:27, Will Deacon <will.deacon@arm.com> wrote:
>> On Fri, Apr 19, 2013 at 10:25:35AM +0100, Pranavkumar Sawargaonkar wrote:
>>> I am not against using 8250 emulation (as far as it solves printk
>>> issues for kernel booting logs), but my point is why not to add early
>>> read-write support for virtio console, which also can be useful in
>>> emulation less mach-virt environment also ?
>>
>> We can have both, but only one of those requires a change to the virtio
>> specification.
>
> I don't think avoiding writing a spec is necessarily a good reason
> for insisting on emulation of a lump of hardware 95% of whose
> capabilities you aren't going to use...

True.
Also 8250 will require emulation of registers, and i am not sure about
if mach-virt will have any emulation of real hw ?

Thanks,
Pranav

>
> -- PMM

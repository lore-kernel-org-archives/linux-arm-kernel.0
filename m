From: linucherian@gmail.com (Linu Cherian)
Date: Sun, 26 Feb 2017 10:00:14 +0530
Subject: [PATCH V2 1/2] KVM: arm/arm64: Enable KVM_CAP_NR_MEMSLOTS on
 arm/arm64
In-Reply-To: <20170223101027.GA1409@cbox>
References: <1486538141-30627-1-git-send-email-linucherian@gmail.com>
 <1486538141-30627-2-git-send-email-linucherian@gmail.com>
 <20170223101027.GA1409@cbox>
Message-ID: <CAGOz-0ZK3HmepGyWMZqEWzCpmvZKNMXOBW5fw=nRtT-pz+e8RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2017 at 3:40 PM, Christoffer Dall <cdall@linaro.org> wrote:
> On Wed, Feb 08, 2017 at 12:45:40PM +0530, linucherian at gmail.com wrote:
>> From: Linu Cherian <linu.cherian@cavium.com>
>>
>> Return KVM_USER_MEM_SLOTS for userspace capability query on
>> NR_MEMSLOTS.
>
> This feature seems to be undocumented (I cannot find it in
> Documentation/virtual/kvm/api.txt).
>
> Can we add documentation for it?
>
> What does user space do currently without this capability?  Does it just
> rely on some default?
>

Yes, without this capability,  qemu userspace take the default value of 32.
Will give it a try on the documentation part as a separate patch.

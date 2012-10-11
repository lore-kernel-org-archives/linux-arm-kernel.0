From: rusty@rustcorp.com.au (Rusty Russell)
Date: Thu, 11 Oct 2012 12:12:58 +1030
Subject: [kvmarm] [PATCH v2 12/14] KVM: ARM: VFP userspace interface
In-Reply-To: <CANM98qJDhHDBPq=XinLaXJG8e07-HhVBfd-2i3a68CumdXuFaw@mail.gmail.com>
References: <20121001090945.49198.68950.stgit@ubuntu>
 <20121001091125.49198.90819.stgit@ubuntu>
 <CAFEAcA8zLr5mPYnd6EzaxyugASWPzvY4RE6LiE-K2uRRGWtFZA@mail.gmail.com>
 <CANM98qJDhHDBPq=XinLaXJG8e07-HhVBfd-2i3a68CumdXuFaw@mail.gmail.com>
Message-ID: <87626h942l.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christoffer Dall <c.dall@virtualopensystems.com> writes:
> On Tue, Oct 9, 2012 at 2:11 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 1 October 2012 10:11, Christoffer Dall <c.dall@virtualopensystems.com> wrote:
>>> From: Rusty Russell <rusty.russell@linaro.org>
...
>>> +ARM 32-bit VFP control registers have the following id bit patterns:
>>> +  0x4002 0000 0012 1 <selector:3>
>>> +
>>> +ARM 64-bit FP registers have the following id bit patterns:
>>> +  0x4002 0000 0012 0 <selector:3>
>>> +
>>
>> In the other entries in this section, <foo:3> indicates a 3 bit field.
>> But I think for these two it's trying to indicate a 3 byte field.
...
> right you are, I'll modify this.

Thanks!
Rusty.

From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 27 May 2014 08:09:19 +0800
Subject: Fwd: [GIT PULL]]ARM: sirf: dts update for 3.16
In-Reply-To: <20140526220355.GV27093@quad.lixom.net>
References: <CAGsJ_4waeAPJjnKiuXBJXXF-bYud=uO_j1hrS9auBAGr8KcFiQ@mail.gmail.com>
 <CAGsJ_4zahocmgi0iJauaaXKBM6A8UCC86r5TLUj3AH68PrTwFA@mail.gmail.com>
 <20140526220355.GV27093@quad.lixom.net>
Message-ID: <CAGsJ_4y0txOXqgS6yDeoN=XZjWe6Z7MtL8gF4hF1fshK2+oAdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-05-27 6:03 GMT+08:00 Olof Johansson <olof@lixom.net>:
> On Sat, May 24, 2014 at 07:07:47AM +0800, Barry Song wrote:
>> Hi Arnd/Olof,
>> hope you don't mind i send a mail to you. is this one missed?
>
> Yeah, it's common that I miss pull requests sent directly to me and not cc:d to
> arm at kernel.org. I normally base most of my merges on the arm at kernel.org email
> folder contents.

yes. arm at kernel.org should always be cc:d.

>
>> From: Barry Song <21cnbao@gmail.com>
>> Date: 2014-05-09 21:53 GMT+08:00
>> Subject: [GIT PULL]]ARM: sirf: dts update for 3.16
>> To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
>> Kevin Hilman <khilman@linaro.org>,
>> "linux-arm-kernel at lists.infradead.org"
>> <linux-arm-kernel@lists.infradead.org>
>> ??? DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>
>>
>>
>> Hi Arnd, Olof, Kevin,
>>
>> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
>>
>>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
>> tags/sirf-dts-for-3.16
>>
>> for you to fetch changes up to b01c5905c29d7d5748a24267bb2486e4a1605fda:
>>
>>   ARM: dts: sirf: add resets for dspif, gps and dsp nodes (2014-05-08
>> 14:13:08 +0800)
>>
>> ----------------------------------------------------------------
>> some minor cleanup and add some missed nodes:
>> 1. move dma channel descriptions to generic dma properity;
>
> Does the driver handle older bindings still, or did you remove support for
> that? We're trying to move to a model where newer kernels work with older
> device trees, so drivers need to still handle the old descriptions.
>

i have been moving clients driver and dts to use new bindings.

> If there's no downstream users of the old description you're free to remove it,
> but it can sometimes be hard to tell if there are or not. As maintainer for
> your platform you're the one who is most likely to know, so I'll leave it to
> you. :)

we will not support old binding as no sirf user uses old dts for new kernel.

>
>> 2. add resets properity for some nodes;
>> 3. add missed pinctrl groups.
>
> Merged into next/dt. Thanks!
>

thanks, Olof.

-barry

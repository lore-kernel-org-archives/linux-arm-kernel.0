From: christian.gmeiner@gmail.com (Christian Gmeiner)
Date: Mon, 11 Nov 2013 15:30:56 +0100
Subject: imx-drm: possible circular locking dependency detected
In-Reply-To: <20131111140614.GZ16735@n2100.arm.linux.org.uk>
References: <CAH9NwWdswcfwVOoCz3AmS8O7Adaun5tf3QJh5YE2iK96d3ajOg@mail.gmail.com>
 <CAOMZO5A1i2jf1Mw-js=+ZF=rRL5JZFHD_d-KMhsqOuaZQx-9zw@mail.gmail.com>
 <CAH9NwWdXxzQc3zJrH+p2bV8js2Pz5tA8HZRDjWrWkvFBeSd2Eg@mail.gmail.com>
 <20131111140614.GZ16735@n2100.arm.linux.org.uk>
Message-ID: <CAH9NwWfjBTkWpJWjJasB=87yRMgEM=pGJmL4oL0FWrG7RRkWBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/11/11 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Nov 11, 2013 at 01:08:24PM +0100, Christian Gmeiner wrote:
>> Hi Fabio
>>
>> 2013/11/11 Fabio Estevam <festevam@gmail.com>:
>> > Hi Christian,
>> >
>> > On Mon, Nov 11, 2013 at 7:25 AM, Christian Gmeiner
>> > <christian.gmeiner@gmail.com> wrote:
>> >> I am not sure if this problem is known but here is dmesg output. If a
>> >> kernel config is needed I can
>> >> send it
>> >
>> > Please apply this patch:
>> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/staging/imx-drm/imx-drm-core.c?id=c35d6a37bdcb1dde42dd65b00676696e2dd78f2f
>> >
>>
>> thanks
>
> If you're looking at using imx-drm, please note that I have a substantial
> pile of patches against this now - some 58 patches.  I'll be posting them
> only once v3.13-rc1 has been released.

It may sounds brutal but my company is using the imx-drm for a new
device which will ship in Q1 2014.
So I am very interested in your patches and can do some testing.

greets
--
Christian Gmeiner, MSc

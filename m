From: per.fransson.ml@gmail.com (Per Fransson)
Date: Fri, 20 Jan 2012 22:28:44 +0100
Subject: [PATCH] ARM: ux500: Initialize irq affinity
In-Reply-To: <20120120174456.GB11845@n2100.arm.linux.org.uk>
References: <1327064356-3603-1-git-send-email-per.xx.fransson@stericsson.com>
 <20120120130310.GO1068@n2100.arm.linux.org.uk>
 <CACRpkdYgT-Q+ZEzhjOaOb_2Pihx0-pMXo+Dc-CESDT7BAWAOqg@mail.gmail.com>
 <20120120174456.GB11845@n2100.arm.linux.org.uk>
Message-ID: <CAMN7GVrh16YaheSwMy-MYame5hQRqdRRbWTf4cVPrj=kvVCf-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 6:44 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 20, 2012 at 04:45:40PM +0100, Linus Walleij wrote:
>> On Fri, Jan 20, 2012 at 2:03 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Fri, Jan 20, 2012 at 01:59:16PM +0100, Per Fransson wrote:
>> >> Use irq_set_affinity() to initialize the kernel view of irq affinity
>> >> when programming the GIC registers.
>> >
>> > Why is this necessary?
>>
>> Necessary: we don't quite know. (Maybe should have been RFC, but
>> this patch is better than being silent of it...)
>
> I'm afraid Per Fransson took the thread off the mailing lists,
> so my reply to him also wasn't public. ?Here's what I said:
>

Oh, I did do that. My apologies.

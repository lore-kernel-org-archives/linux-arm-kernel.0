From: david@lang.hm (David Lang)
Date: Fri, 29 May 2015 15:16:42 -0700 (PDT)
Subject: Device Tree Blob (DTB) licence
In-Reply-To: <55684F07.7050402@melag.de>
References: <1430820315.19516.26.camel@opteya.com>
 <CAL_Jsq+T5c7qornpRVCduEjUSCeM+0xqbtVYovtH76y=4BqhLQ@mail.gmail.com>
 <1432289148.5304.58.camel@opteya.com> <1432322832.5304.63.camel@opteya.com>
 <CAOS_Y6Q37ps+VEnzUZ_uwX++qrRm9Hgx45Q_pmiZSLSNjmKwZg@mail.gmail.com>
 <55670AD4.8020705@melag.de> <20150528133429.GD2067@n2100.arm.linux.org.uk>
 <556747E4.6070403@melag.de> <20150529064741.GB25351@1wt.eu>
 <55684F07.7050402@melag.de>
Message-ID: <alpine.DEB.2.02.1505291512000.4429@nftneq.ynat.uz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 May 2015, Enrico Weigelt, metux IT consult wrote:

>>> And why should they fear "poisoning" ?
>> 
>> Search for "GPL contamination", the problem is quite common, GPL
>> can turn anything GPL-compatible into GPL. So for a non-GPL project
>> it's very hard to adopt GPL code.
>
> Yes, that's the whole purpose of the GPL. The deal is pretty simple:
> if you take some GPL'ed software and change it, you'll have to publish
> your changes under the same rules. For entirely separate entities
> (eg. dedicated programs) that's not an big issue. And for libraries,
> we have LGPL.
>
> If the DTS license would be a problem, it would be worse w/ ACPI
> and any proprietary firmware/BIOSes.

not true, with a proprietary bios it's a clear "pay this much money and don't 
worry about it" while with GPL there's a nagging fear that someone you never 
heard of may sue you a decade from now claiming you need to give them the source 
to your OS.

Is having the DTB GPL so impartant that you would rather let things fall into 
the windows trap ("well it booted windows, so it must be right") instead of 
allowing a proprietary OS to use your description of the hardware?

note, this whole discussion assumes that the DTB is even copyrightable. Since 
it's intended to be strictly a functional description of what the hardware is 
able to do, that could be questioned

David Lang

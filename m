From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 08 Mar 2017 09:54:16 +0100
Subject: [PATCH v2] ARM: mvebu: add support for the Linksys WRT1900ACS
 (Shelby)
In-Reply-To: <20170307184847.0c684b36@gmail.com> (Ralph Sennhauser's message
 of "Tue, 7 Mar 2017 18:48:47 +0100")
References: <20170214191744.9419-1-ralph.sennhauser@gmail.com>
 <87inobcwk3.fsf@free-electrons.com>
 <87zigxngjq.fsf@free-electrons.com>
 <20170307184847.0c684b36@gmail.com>
Message-ID: <8737eono7b.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ralph,
 
 On mar., mars 07 2017, Ralph Sennhauser <ralph.sennhauser@gmail.com> wrote:

> On Tue, 07 Mar 2017 18:27:21 +0100
> Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
>> 
>> It is now in mvebu/dt and in the same time I fixed the title to:
>> "ARM: dts: armada-385: add support for the Linksys WRT1900ACS
>> (Shelby)"
>> 
>> Gregory
>> 
>
> Thanks
> Ralph
>
> PS: The sort order got mixed with armada-385-synology-ds116.dtb while
> merging which got added minutes earlier in arch/arm/boot/dts/Makefile.

Thanks for info, I've fixed it now.

>
> PPS: There was also the request of using SPDX tags to v1 after v2 got
> merged from Rob Herring and a no by Russell King. I took it as no
> action required, you might want to have a look though.

I saw this and it was the first time I see this kind of request about
SPDX tags. Given the answer from Russell Kng I don't plan to do
anything for now.

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

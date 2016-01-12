From: balbi@ti.com (Felipe Balbi)
Date: Tue, 12 Jan 2016 10:52:08 -0600
Subject: [PATCH] arm: omap2plus_defconfig: enable SPLIT and DWARF4
In-Reply-To: <20160111233438.GB12777@atomide.com>
References: <1452547572-23515-1-git-send-email-balbi@ti.com>
 <20160111233438.GB12777@atomide.com>
Message-ID: <87mvsad9l3.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Tony Lindgren <tony@atomide.com> writes:
> * Felipe Balbi <balbi@ti.com> [160111 13:26]:
>> CONFIG_DEBUG_INFO_SPLIT will split debug info on
>> .dwo files. This will generate a smaller vmlinux and
>> smaller .ko modules, which will be easier to ship on
>> certain products.
>> 
>> CONFIG_DEBUG_INFO_DWARF4 will generate debug info in
>> DWARF4 format, which ends up being larger, but
>> improves the probability of resolving variables in
>> optmized code.
>
> Nice, this makes my initramfs go down from about 17MB
> to 4.7 MB :)

That's nice, let's just hope nobody has issues with this patch.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160112/9e4b631d/attachment.sig>

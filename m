From: kaloz@openwrt.org (Imre Kaloz)
Date: Tue, 19 Jul 2011 13:09:00 +0200
Subject: [PATCH v2] ARM: support XZ compressed kernels
In-Reply-To: <20110719110235.GH26574@n2100.arm.linux.org.uk>
References: <1310475369-3000-1-git-send-email-kaloz@openwrt.org>
	<20110715162519.GC24628@n2100.arm.linux.org.uk>
	<op.vyptiwow2s3iss@ecaz>
	<20110719110235.GH26574@n2100.arm.linux.org.uk>
Message-ID: <op.vyu49amq2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Jul 2011 13:02:35 +0200, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Sat, Jul 16, 2011 at 04:07:34PM +0200, Imre Kaloz wrote:
>> On Fri, 15 Jul 2011 18:25:19 +0200, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>>
>>> On Tue, Jul 12, 2011 at 02:56:09PM +0200, Imre Kaloz wrote:
>>>> Wire up support for the XZ decompressor
>>>
>>> Ok.
>>
>> Thanks, added to the patch system.
>
> FYI:
>
> Patching 7001/1...
> <stdin>:56: space before tab in indent.
>                 $(addprefix $(obj)/, $(OBJS)) $(lib1funcs) $(ashldi3) FORCE
> warning: 1 line applied after fixing whitespace errors.
>

That space is there since there's git history for the file ;)


Imre

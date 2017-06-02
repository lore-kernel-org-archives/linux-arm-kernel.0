From: balbi@kernel.org (Felipe Balbi)
Date: Fri, 02 Jun 2017 13:07:24 +0300
Subject: [PATCH v4 3/3] USB3/DWC3: Enable undefined length INCR burst type
In-Reply-To: <DB5PR0401MB181366E27C238DF8B2228B00FE170@DB5PR0401MB1813.eurprd04.prod.outlook.com>
References: <1484727138-3264-1-git-send-email-jerry.huang@nxp.com>
 <1484727138-3264-3-git-send-email-jerry.huang@nxp.com>
 <DB5PR0401MB1813965DDC8CC6CD0BD85980FE440@DB5PR0401MB1813.eurprd04.prod.outlook.com>
 <87y3xeqvsl.fsf@linux.intel.com>
 <DB5PR0401MB1813AAB5AA84B0B310ED1B10FE440@DB5PR0401MB1813.eurprd04.prod.outlook.com>
 <87tw71xthj.fsf@linux.intel.com>
 <DB5PR0401MB181366E27C238DF8B2228B00FE170@DB5PR0401MB1813.eurprd04.prod.outlook.com>
Message-ID: <87a85qvh2b.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Jerry Huang <jerry.huang@nxp.com> writes:
>> Jerry Huang <jerry.huang@nxp.com> writes:
>> >> >> --
>> >> >> 1.7.9.5
>> >> > Hi, Balbi and all guys,
>> >> > Any comment for these patches? Can they be accepted?
>> >>
>> >> Rob had comments which you didn't reply yet. I cannot take this
>> >> patchset yet ;-)
>> >>
>> > Balbi,
>> >
>> > I look into his mail again, which was based v3, and I replied it.
>> >
>> > He had different understanding for undefined length burst mode.
>> >
>> > It seems he think for this mode, just setting bit[0] (INCRBrstEna) and
>> > don't need to set other field.
>> >
>> > However, according to the DWC USB3.0 controller databook, when it is
>> > undefined length INCR burst mode, we still need to set one max burst
>> > type, such as INCR8, which means controller will use any length less
>> > than or equal to this INCR8.
>> 
>> Rob, do you agree with the patch now?
>> 
>> --
>> balbi
>
> Hi, Balbi,
> Any comment for these patches? Or any chance to merge them?

I'm not sure you understand how development is carried out here. I
*can't* apply patches touching Device Tree properties without an
Acked-by from any of the Device Tree maintainers. Until then, there's
nothing I can say/do.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170602/621e0e10/attachment.sig>

From: balbi@kernel.org (Felipe Balbi)
Date: Fri, 10 Mar 2017 13:26:48 +0200
Subject: [PATCH v4 3/3] USB3/DWC3: Enable undefined length INCR burst type
In-Reply-To: <DB5PR0401MB1813AAB5AA84B0B310ED1B10FE440@DB5PR0401MB1813.eurprd04.prod.outlook.com>
References: <1484727138-3264-1-git-send-email-jerry.huang@nxp.com>
 <1484727138-3264-3-git-send-email-jerry.huang@nxp.com>
 <DB5PR0401MB1813965DDC8CC6CD0BD85980FE440@DB5PR0401MB1813.eurprd04.prod.outlook.com>
 <87y3xeqvsl.fsf@linux.intel.com>
 <DB5PR0401MB1813AAB5AA84B0B310ED1B10FE440@DB5PR0401MB1813.eurprd04.prod.outlook.com>
Message-ID: <87tw71xthj.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Jerry Huang <jerry.huang@nxp.com> writes:
>> >> --
>> >> 1.7.9.5
>> > Hi, Balbi and all guys,
>> > Any comment for these patches? Can they be accepted?
>> 
>> Rob had comments which you didn't reply yet. I cannot take this patchset
>> yet ;-)
>> 
> Balbi,
>
> I look into his mail again, which was based v3, and I replied it.
>
> He had different understanding for undefined length burst mode.
>
> It seems he think for this mode, just setting bit[0] (INCRBrstEna) and
> don't need to set other field.
>
> However, according to the DWC USB3.0 controller databook, when it is
> undefined length INCR burst mode, we still need to set one max burst
> type, such as INCR8, which means controller will use any length less
> than or equal to this INCR8.

Rob, do you agree with the patch now?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170310/13354915/attachment.sig>

From: arve@android.com (=?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?=)
Date: Wed, 14 Nov 2012 15:25:57 -0800
Subject: Decoding the PTM traces
In-Reply-To: <CAKZGPAN-DEFD-X4az0O06ngjwdFAyrdowQ57QvtDpe8axZiwTg@mail.gmail.com>
References: <CAKZGPAN-DEFD-X4az0O06ngjwdFAyrdowQ57QvtDpe8axZiwTg@mail.gmail.com>
Message-ID: <CAMP5XgegGNn=NM8LEp61tZJWYQC3wbZ9mFz53cMsvPFr=bydaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 6:04 AM, Arun KS <arunks.linux@gmail.com> wrote:
> Hello,
>
> I m trying to capture and decode PTM trace from Cortex A9 dual core.
>
> I m successful  in configuring the driver(arch/arm/kernel/etm.c) and
> setting the funnel to get data in ETB.
> But I don't know how to decode these traces.
>
> Anyone has any pointers?
>
> Thanks,
> Arun

I attached some tools I use to decode the traces. I have used this on
the A8, A9 and A15. I assume since you cc-ed me you have already
applied the kernel patches I posted a while back. Without them you
will not get useful trace data from a dual core processor.

-- 
Arve Hj?nnev?g
-------------- next part --------------
A non-text attachment was scrubbed...
Name: etm.c
Type: text/x-csrc
Size: 20847 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121114/7058a281/attachment-0001.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: objdump.py
Type: application/octet-stream
Size: 6317 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121114/7058a281/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: etm-objdump.py
Type: application/octet-stream
Size: 6984 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121114/7058a281/attachment-0003.obj>

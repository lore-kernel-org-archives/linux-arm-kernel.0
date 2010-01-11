From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 11 Jan 2010 02:23:28 -0500
Subject: [PATCH 1/1] pxa168: avenergs lite board bring up
In-Reply-To: <f17812d71001080533l7e555cf6wf90a345a83999e7d@mail.gmail.com>
References: <771cded01001080054y14ca6ac9n469a59ec77bf0a9e@mail.gmail.com>
	<f17812d71001080533l7e555cf6wf90a345a83999e7d@mail.gmail.com>
Message-ID: <771cded01001102323xd6eb924q78a830b1d65334a8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 8, 2010 at 8:33 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
>> +/* Avengers lite MFP configurations */
>> +static unsigned long avengers_lite_pin_config_V16F[] __initdata = {
>> + ? ? ? /* DEBUG_UART */
>> + ? ? ? MFP_CFG(GPIO88, AF2),
>> + ? ? ? MFP_CFG(GPIO89, AF2),
>> +};
>> +
>
> We may add these two definitions into mfp-pxa168.h so that other
> pxa168-based platform can reuse.
>
> Otherwise looks OK to me.
>

Updated. Thanks

Best Regards
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-pxa168-avengers-lite-board-bring-up.patch
Type: text/x-patch
Size: 16364 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100111/6828f106/attachment-0001.bin>

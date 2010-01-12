From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 12 Jan 2010 14:35:31 +0800
Subject: [PATCH 1/1] pxa168: avenergs lite board bring up
In-Reply-To: <771cded01001102323xd6eb924q78a830b1d65334a8@mail.gmail.com>
References: <771cded01001080054y14ca6ac9n469a59ec77bf0a9e@mail.gmail.com>
	<f17812d71001080533l7e555cf6wf90a345a83999e7d@mail.gmail.com>
	<771cded01001102323xd6eb924q78a830b1d65334a8@mail.gmail.com>
Message-ID: <f17812d71001112235m7caba518v34f430afff850179@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 3:23 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Fri, Jan 8, 2010 at 8:33 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>> +/* Avengers lite MFP configurations */
>>> +static unsigned long avengers_lite_pin_config_V16F[] __initdata = {
>>> + ? ? ? /* DEBUG_UART */
>>> + ? ? ? MFP_CFG(GPIO88, AF2),
>>> + ? ? ? MFP_CFG(GPIO89, AF2),
>>> +};
>>> +
>>
>> We may add these two definitions into mfp-pxa168.h so that other
>> pxa168-based platform can reuse.
>>
>> Otherwise looks OK to me.
>>
>
> Updated. Thanks
>

Applied to 'devel'. Patch separated into two: the base support
for avlite and pxa168_defconfig update.

From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 6 May 2010 23:54:08 +0800
Subject: [PATCH v2] ARM: Add support for LZMA-compressed kernel images
In-Reply-To: <x2vbbb699fe1005060630tab568c6aj2e23bb0665a1644a@mail.gmail.com>
References: <1258729323-16318-1-git-send-email-albin.tonnerre@free-electrons.com>
	<1268335467-24223-1-git-send-email-albin.tonnerre@free-electrons.com>
	<4BAB2552.9070704@gmail.com>
	<x2nd1b08f941005060204j3bbf3fc9z11cc4325a20bdb82@mail.gmail.com>
	<x2vbbb699fe1005060630tab568c6aj2e23bb0665a1644a@mail.gmail.com>
Message-ID: <v2zf17812d71005060854o2f24263bl33e5ea8e25921d6c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 6, 2010 at 9:30 PM, Albin Tonnerre <albin.tonnerre@gmail.com> wrote:
> On Thu, May 6, 2010 at 11:04 AM, Andrea Adami <andrea.adami@gmail.com> wrote:
>> Any reason to further delay the LZMA adoption?
>> It will not be the fastest decompressor, but gives the smallest kernel size.
>> Tested on various Zaurus models (pxa255, pxa270, armv4).
>
> It's in the devel branch of Russell's tree already, so it should find
> its way to mainline :)
>

Tested on my zaurus, worked just out of the box. Thanks.

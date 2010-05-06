From: albin.tonnerre@gmail.com (Albin Tonnerre)
Date: Thu, 6 May 2010 15:30:22 +0200
Subject: [PATCH v2] ARM: Add support for LZMA-compressed kernel images
In-Reply-To: <x2nd1b08f941005060204j3bbf3fc9z11cc4325a20bdb82@mail.gmail.com>
References: <1258729323-16318-1-git-send-email-albin.tonnerre@free-electrons.com>
	<1268335467-24223-1-git-send-email-albin.tonnerre@free-electrons.com>
	<4BAB2552.9070704@gmail.com>
	<x2nd1b08f941005060204j3bbf3fc9z11cc4325a20bdb82@mail.gmail.com>
Message-ID: <x2vbbb699fe1005060630tab568c6aj2e23bb0665a1644a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 6, 2010 at 11:04 AM, Andrea Adami <andrea.adami@gmail.com> wrote:
> Any reason to further delay the LZMA adoption?
> It will not be the fastest decompressor, but gives the smallest kernel size.
> Tested on various Zaurus models (pxa255, pxa270, armv4).

It's in the devel branch of Russell's tree already, so it should find
its way to mainline :)

Regards,
Albin

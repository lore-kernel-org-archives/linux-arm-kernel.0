From: kaloz@openwrt.org (Imre Kaloz)
Date: Fri, 08 Jul 2011 20:50:10 +0200
Subject: [PATCH] ARM: support XZ compressed kernels
In-Reply-To: <alpine.LFD.2.00.1107071513440.14596@xanadu.home>
References: <1310033999-25617-1-git-send-email-kaloz@openwrt.org>
	<alpine.LFD.2.00.1107071513440.14596@xanadu.home>
Message-ID: <op.vybc9wzk2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 07 Jul 2011 21:14:58 +0200, Nicolas Pitre <nico@fluxnic.net> wrote:

> On Thu, 7 Jul 2011, Imre Kaloz wrote:
>
>> Wire up support for the XZ decompressor
>>
>> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
>> ---
>>  arch/arm/Kconfig                        |    1 +
>>  arch/arm/boot/compressed/Makefile       |   11 +++++++++--
>>  arch/arm/boot/compressed/decompress.c   |    4 ++++
>>  arch/arm/boot/compressed/piggy.xzkern.S |    6 ++++++
>>  lib/xz/xz_dec_stream.c                  |    1 +
>>  5 files changed, 21 insertions(+), 2 deletions(-)
>
> Please don't forget to update arch/arm/boot/compressed/.gitignore

Thanks, will do and resend if no other replies come in.


Imre

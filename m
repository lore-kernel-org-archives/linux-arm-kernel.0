From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Jun 2015 10:16:28 +0200
Subject: [PATCH 1/2 v2] ARM64: juno: add GPIO keys
In-Reply-To: <20150601164341.GE2175@e106497-lin.cambridge.arm.com>
References: <1432629650-19559-1-git-send-email-linus.walleij@linaro.org>
 <20150526093734.GB2175@e106497-lin.cambridge.arm.com>
 <CACRpkdbm9LxaWQa=SQAhOKYVncPoFiKv_M6cN1oUEqctiR5=pQ@mail.gmail.com>
 <20150527144052.GF2175@e106497-lin.cambridge.arm.com>
 <CACRpkdaem5kTvgiswkp7SB+nJntDpV1Ycai1hzm2kWcpA+rKSA@mail.gmail.com>
 <20150601164341.GE2175@e106497-lin.cambridge.arm.com>
Message-ID: <CACRpkdaQBxt6t8hosym5x0p5trfE93y8bac6HtqVaX0GvLdheQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 1, 2015 at 6:43 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> On Mon, Jun 01, 2015 at 10:02:10AM +0100, Linus Walleij wrote:

> I have tested the patches on my Juno R0, so you can add my
>
> Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

OK thanks!

>> > UEFI firmware (version a4c2dfb284a55e73f34c48f5944a438006384f04 built at 17:44:48 on Jan 13 2015)
>>
>> I'm using U-Boot, of course ;)
>
> Should I, too? :)

I think it's very convenient especially if you just want to boot the kernel off
TFTP like with most reference designs. I compile a U-Boot with a command
string like so as default:
set serverip 192.168.1.32 ; set ipaddr 192.168.1.35 ; tftpboot
0x80000000 Image ; tftpboot 0x83000000 juno.dtb ; booti 0x80000000 -
0x83000000

Then I can just compile a kernel I want to test and reboot and it
will download and boot whatever I just compiled quick and nice
with no keyboard interaction.
http://www.df.lth.se/~triad/krad/junoboard/

Yours,
Linus Walleij

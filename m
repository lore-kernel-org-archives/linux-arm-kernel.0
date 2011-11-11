From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Nov 2011 18:00:10 +0100
Subject: [PATCH] mach-ux500: add devicetree compat nodes
In-Reply-To: <4EBD4F79.90302@gmail.com>
References: <1321023902-18870-1-git-send-email-niklas.hernaeus@linaro.org>
 <4EBD3C85.1010508@gmail.com>
 <CACRpkda-9OVP8E1qO3Nc5znw_v7cKFiv8T5HHwTCnY2C9Fg7iA@mail.gmail.com>
 <4EBD49A6.2020306@gmail.com>
 <CACRpkdZrWW2jUYC0P7yY322YMdn9+4_NaGPhKtpGwR+e=F6+0A@mail.gmail.com>
 <4EBD4F79.90302@gmail.com>
Message-ID: <CACRpkdb6n2mRWohGrv1d0VFLRsTMDPDzow7UY6jw=9rdt-ZkqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 5:38 PM, Rob Herring <robherring2@gmail.com> wrote:
> [Me]
>> In that case we should hold this patch off and only keep it for
>> internal testing until all necessary drivers are ready and patched
>> so we can replace all board files with a single DT-based one,
>> instead of this compromise solution.
>>
> I would not hold off. You only need to have a minimal set that's enough
> to boot.

In our case UART, I2C and MMC is necessary to boot, so then we
anyway need to wait for these to be patched first. So we'd better hold
it back for now I think.

Linus Walleij

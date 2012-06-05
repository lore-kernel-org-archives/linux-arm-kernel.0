From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Jun 2012 14:59:29 +0200
Subject: [PATCH 6.2/7] MMC: mmci: Enable Device Tree support for ux500
In-Reply-To: <20120605105249.GK8262@n2100.arm.linux.org.uk>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdYyP=V=aXtDuo_W4oDxH0UkQKq1x1HKG_z=zWHoWng6JQ@mail.gmail.com>
 <4F8BE5B0.4000900@linaro.org>
 <20120604101447.GF8262@n2100.arm.linux.org.uk>
 <4FCDE3D7.9030006@linaro.org>
 <20120605105249.GK8262@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdY=os8B2JEVijHzdfqUN_Q075MLoVsk3U=owAPhmcNUHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 5, 2012 at 12:52 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 05, 2012 at 11:47:51AM +0100, Lee Jones wrote:
>> On 04/06/12 11:14, Russell King - ARM Linux wrote:
>> > So why is this buggy patch now merged in the mainline kernel?
>>
>> I guess Chris took it because you said it was fine?
>
> Err, no. ?If you re-read the thread, you'll see that I said your
> subsequent patch posted on Thu, 03 May 2012 16:30:48 +0100 with
> the devm_kzalloc() was fine.

Lee can you provide an incremental fixup that makes the current
code textually equivalent to what Russell ACKed (devm_kzalloc()),
and funnel to Chris for the -rc:s ASAP?

Yours,
Linus Walleij

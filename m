From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Jan 2014 15:38:58 +0100
Subject: [PATCH 18/20] clocksource / acpi: Add macro
 CLOCKSOURCE_ACPI_DECLARE
In-Reply-To: <20140122114537.GA15591@e106331-lin.cambridge.arm.com>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org>
 <CACRpkdYKwaH5DX27irzmcTDAMhQMUhuzz6N7mjKWv9tZchv0Ug@mail.gmail.com>
 <20140122114537.GA15591@e106331-lin.cambridge.arm.com>
Message-ID: <CACRpkda1UoGV1anjZqPVXQU1+=xU3g3zpAvuu7C2sbhJgw+dSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 12:45 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Jan 22, 2014 at 08:26:50AM +0000, Linus Walleij wrote:

>> This hammers down the world to compile one binary for ACPI
>> and one binary for device tree. Maybe that's fine, I don't know.
>
> How does it do that?

Bah it doesn't I misread the patch. Forget that comment.

Yours,
Linus Walleij

From: olof@lixom.net (Olof Johansson)
Date: Mon, 9 Sep 2013 17:33:19 -0700
Subject: [PATCH 0/3] ARM: PCI: versatile: fix irqs, I/O
In-Reply-To: <87ppsont9q.fsf@linaro.org>
References: <1377190070-7305-1-git-send-email-peter.maydell@linaro.org>
 <CACRpkdYZiTRkivBY6ZsroOce9Oj=R86x3q0Pw9G4X=gUWyL6bw@mail.gmail.com>
 <87ppsont9q.fsf@linaro.org>
Message-ID: <CAOesGMjMXWi29BqOSJqHyNRmkAEru=HeCp03+d2DDixZgDNW_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 4, 2013 at 2:58 PM, Kevin Hilman <khilman@linaro.org> wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:
>
>> On Thu, Aug 22, 2013 at 6:47 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>>> These patches fix a number of issues with the PCI controller
>>> code for mach-versatile:
>>
>> All seem sound to me.
>>
>> Please mark all as Cc: stable at vger.kernel.org
>> and push the ARM SoC maintainers to take these three
>> patches as fixes.
>
> I've picked these up and added the Reviewed-by from Linus and the Cc:
> stable.
>
> They will not likely get into the v3.12 merge window, but will get them
> in during the v3.12-rc

I've merged this into fixes now for 3.12.


-Olof

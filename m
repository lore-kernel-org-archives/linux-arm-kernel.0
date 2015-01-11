From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Jan 2015 22:41:29 +0100
Subject: [PATCH v4 0/7] pinctrl support for Zynq
In-Reply-To: <b987f31220ab424285e27200bb187158@BY2FFO11FD012.protection.gbl>
References: <1420818231-13451-1-git-send-email-soren.brinkmann@xilinx.com>
 <b987f31220ab424285e27200bb187158@BY2FFO11FD012.protection.gbl>
Message-ID: <CACRpkdYLHOHhSYSJZcggmATnMRg_7Pq8-fF3c2MJW9E69DiqJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 9, 2015 at 5:53 PM, S?ren Brinkmann
<soren.brinkmann@xilinx.com> wrote:
> On Fri, 2015-01-09 at 07:43AM -0800, Soren Brinkmann wrote:
>> Hi Linus,
>>
>> I rebased my branch onto your current pinctrl/devel. Other than that
>> this should be exactly what has been sent out as v3. This time I'll use
>> the gmail SMTP again, which hopefully resolves the encoding issue.
>
> The transfer-encoding is again 'quoted-printable'. So, seems it is not
> exchange to blame. I tried to git am a patch from this series and it
> seems to work fine. I.e. send-email and am apparently to the right
> thing.

Yeah it works like a charm :)

All patches that affect the pin control tree are applied now. It is
looking *beautiful* especially your device trees look exactly as I
want them to look for a group/function type pin controller driver.

Yours,
Linus Walleij

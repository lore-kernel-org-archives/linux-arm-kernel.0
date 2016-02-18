From: k@japko.eu (Krzysztof Adamski)
Date: Thu, 18 Feb 2016 20:42:56 +0100
Subject: [linux-sunxi] Re: [PATCH] clk: sunxi: Add missing H3 apb0 clock
 documentation
In-Reply-To: <CAGb2v67PiQHVQfhbsk2f3aQFOaDXHy3P+NJDoTw-+GshubWaYQ@mail.gmail.com>
References: <CACRpkdbfNeh7_=3ReQtJc7OxkkQEn+BUhZ0O0SKnFsRD=WZiUQ@mail.gmail.com>
 <1455807809-30827-1-git-send-email-k@japko.eu>
 <CAGb2v67PiQHVQfhbsk2f3aQFOaDXHy3P+NJDoTw-+GshubWaYQ@mail.gmail.com>
Message-ID: <20160218194255.GD18745@box2.japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 09:07:16AM -0800, Chen-Yu Tsai wrote:
>On Thu, Feb 18, 2016 at 7:03 AM, Krzysztof Adamski
><krzysztof.adamski@tieto.com> wrote:
>> allwinner,sun8i-h3-apb0-gates-clk was added by
>> commit ba83a11104ae ("pinctrl: sunxi: Add H3 R_PIO controller support")
>> but the patch was missing proper binding documentation. This patch fixes
>> this issue.
>
>What are you talking about? The commit you mentioned only adds the pinctrl
>driver. Your H3 PRCM related clock and reset patches are still pending.
>No need for this patch as your earlier patches includes this.

Damn, I messed up patches, I must have been tired or something. It was 
documentation for "allwinner,sun8i-h3-r-pinctrl" that was missing. I'm 
sending a new patch. Sorry for confusion.

Best regards,
Krzysztof Adamski

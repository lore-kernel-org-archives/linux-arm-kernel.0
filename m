From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 16 Dec 2014 08:34:06 -0800
Subject: [PATCH v2 2/2] ARM: mediatek: dts: Add bindings for watchdog
In-Reply-To: <CABuKBe+=PaJ2BuhoGGwn8V20207QU3zzWb4UGgXzwwF-AvBEPw@mail.gmail.com>
References: <1418395859-32209-1-git-send-email-matthias.bgg@gmail.com>
 <1418395859-32209-3-git-send-email-matthias.bgg@gmail.com>
 <548C5F1F.8070804@roeck-us.net>
 <CABuKBe+=PaJ2BuhoGGwn8V20207QU3zzWb4UGgXzwwF-AvBEPw@mail.gmail.com>
Message-ID: <20141216163406.GB26966@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 05:14:35PM +0100, Matthias Brugger wrote:
> 2014-12-13 16:45 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
> > On 12/12/2014 06:50 AM, Matthias Brugger wrote:
> >>
> >> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> >> ---
> >>   Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 13
> >> +++++++++++++
> >>   1 file changed, 13 insertions(+)
> >>   create mode 100644
> >> Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> >> b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> >> new file mode 100644
> >> index 0000000..af9eb5b
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> >> @@ -0,0 +1,13 @@
> >> +Mediatek SoCs Watchdog timer
> >> +
> >> +Required properties:
> >> +
> >> +- compatible : should be "mediatek,mt6589-wdt"
> >
> >
> > "mediatek" is undefined as vendor prefix in the current upstream code.
> > Is this vendor prefix coming in from another patch set ?
> 
> Strange, should be in vendor-prefix.txt [1].
> Please double check.
> 
Sorry, I misunderstood the output from checkpatch.

Guenter

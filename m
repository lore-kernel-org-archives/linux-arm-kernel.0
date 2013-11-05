From: gerg@uclinux.org (Greg Ungerer)
Date: Tue, 05 Nov 2013 23:03:38 +1000
Subject: [PATCH] pinctrl: imx50: add pinctrl support code for the IMX50 SoC
In-Reply-To: <CACRpkdb_c1u8ANtnfPhtYu9ybapmrputwJA=KwZiGpibpqc4OQ@mail.gmail.com>
References: <1383023635-30640-1-git-send-email-gerg@uclinux.org>	<CACRpkdb5U2xBBVerbspTnW5=61kwx0+mvLGZF=VmdOKrN3QhHg@mail.gmail.com>	<20131104132743.GA11031@S2101-09.ap.freescale.net>
 <CACRpkdb_c1u8ANtnfPhtYu9ybapmrputwJA=KwZiGpibpqc4OQ@mail.gmail.com>
Message-ID: <5278ECAA.3070606@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 05/11/13 19:54, Linus Walleij wrote:
> On Mon, Nov 4, 2013 at 2:27 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> On Mon, Nov 04, 2013 at 01:14:32PM +0100, Linus Walleij wrote:
>>> On Tue, Oct 29, 2013 at 6:13 AM,  <gerg@uclinux.org> wrote:
>>>
>>>> From: Greg Ungerer <gerg@uclinux.org>
>>>>
>>>> Add code to support the specific pin arrangements of the Freescale IMX50 SoC.
>>>>
>>>> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
>>>
>>> Can I get some maintainer to review this for the next cycle?
>>
>> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>
> OK I actually tried to apply it now since it is a new driver,
> but it needs rebasing.
>
> Greg could you rebase this on top of the "devel" branch in
> my pinctrl tree so I can  apply the patch?

Yep, sure thing. New patch coming right up.

Regards
Greg

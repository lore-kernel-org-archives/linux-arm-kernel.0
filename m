From: khilman@baylibre.com (Kevin Hilman)
Date: Sun, 01 May 2016 16:48:51 -0700
Subject: [PATCH 1/2] pinctrl: amlogic: Add support for Amlogic Meson GXBB
 SoC
In-Reply-To: <CAOQ7t2YEVsk9cB-kmp-fXSVsVVtXynFbMSxPzTPE_0+s0qY9PQ@mail.gmail.com>
 (Carlo Caione's message of "Sun, 1 May 2016 11:20:14 +0200")
References: <1462036875-22625-1-git-send-email-carlo@caione.org>
 <1462036875-22625-2-git-send-email-carlo@caione.org>
 <CACRpkdbfSgVH_zGMdgyfvBbnpiTkd7dzugza4_w0_7MLMVNzyA@mail.gmail.com>
 <CAOQ7t2YEVsk9cB-kmp-fXSVsVVtXynFbMSxPzTPE_0+s0qY9PQ@mail.gmail.com>
Message-ID: <m2y47tuyos.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Carlo Caione <carlo@caione.org> writes:

> On Sun, May 1, 2016 at 11:03 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Sat, Apr 30, 2016 at 7:21 PM, Carlo Caione <carlo@caione.org> wrote:
>>
>>> From: Carlo Caione <carlo@endlessm.com>
>>>
>>> This patch adds the basic platform file to support the pin controller
>>> found on the Amlogic Meson GXBB SoCs.
>>>
>>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>>
>>>  .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |   2 +
>>
>> This thing conflicts with upstream. Make a separate patch for
>> updating the bindings I think.
>
> This patch is based on linux-next where the documentation is correctly
> updated (see 11ca8735) but apparently this is missing from upstream.
> Probably slipped through the cracks with the latest PR.
>
> Kevin, did you merge both the commits in
> https://patchwork.ozlabs.org/patch/603580/ or just the DT changes?

Yes, I just pulled your branch.

That pull was merged for v4.7, which is why it's in next, but not yet
mainline (where v4.6 is just now being finalized.)

Kevin

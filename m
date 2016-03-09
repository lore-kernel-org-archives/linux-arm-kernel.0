From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 9 Mar 2016 10:50:09 -0700
Subject: [PATCH 2/3] pinctrl: ns2: add pinmux driver support for Broadcom
 NS2 SoC
In-Reply-To: <CACRpkdaKn4puDsZBPSbfkmHW4KHqBW8q1T2vpyNk_0Yb7C0AXQ@mail.gmail.com>
References: <1457005303-26829-1-git-send-email-yendapally.reddy@broadcom.com>
 <1457005303-26829-3-git-send-email-yendapally.reddy@broadcom.com>
 <CACRpkdaKn4puDsZBPSbfkmHW4KHqBW8q1T2vpyNk_0Yb7C0AXQ@mail.gmail.com>
Message-ID: <56E06251.3020502@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2016 04:04 AM, Linus Walleij wrote:
> On Thu, Mar 3, 2016 at 6:41 PM, Yendapally Reddy Dhananjaya Reddy
> <yendapally.reddy@broadcom.com> wrote:
>
>> This adds the initial support of the Broadcom NS2 pinmux driver
>>
>> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
>
> Now yet another Broadcom driver!
>
> Can I get the help of the maintainers of the other
> Broadcom drivers to say:
>
> - If this looks sane
>
> - If this hardware looks suspiciously similar to one of the
>    other drivers and should rather me a subdriver of one of
>    the existing ones

Based on this patch, I don't quickly see any obvious relation between 
this HW and bcm2835. I don't know anything about other bcm pinmux, so 
didn't check those.

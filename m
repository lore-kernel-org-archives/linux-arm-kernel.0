From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 16 Mar 2015 11:58:43 +0100
Subject: [PATCH v4 2/5] ARM: dts: Prepare exynos5410-odroidxu device tree
In-Reply-To: <5506B02D.3000400@suse.de>
References: <1426456834-6308-1-git-send-email-afaerber@suse.de>
 <1426456834-6308-3-git-send-email-afaerber@suse.de>
 <CABxcv==cnFQ75qaykfkOcFo8FNqkzVswu8iYOB3riZJT9=4U_Q@mail.gmail.com>
 <5506B02D.3000400@suse.de>
Message-ID: <CABxcv=kXkMkGkq=xjEBkfzdeFZ7XHDhneAxCgANoMDZ4u2Z4yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas,

On Mon, Mar 16, 2015 at 11:27 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Am 16.03.2015 um 08:56 schrieb Javier Martinez Canillas:
>>
>> I think this should be defined in exynos5410.dtsi instead since is an
>> IP block in the SoC and referenced in the .dts using a label to change
>> the clock-frequency in the board.
>
> I hope you understood that this is a literal copy of smdk5410, so I'm
> not going to make random changes here. If the Samsung guys want to make
> this change for smdk5410, then fine, but otherwise - like for Snow and
> Spring - I want to keep the diff -u low between the two.
>

Yes I did understand that it was a copy but I thought it could be
improved anyways. But I don't have a strong opinion either to block
this series and always both DTS can be changed as a follow-up. So I'm
ok with your decision to keeping the delta to the minimum for now.

>>
>> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>
> Thanks, first review after posting for the third time... ;)
>

You are welcome.

I usually try to review new Exynos5 DTS but I missed your series
before because I was not in the cc list. I only noticed now because
you talked about it on irc.

> Regards,
> Andreas
>

Best regards,
Javier

From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 08 Aug 2014 15:20:19 +0200
Subject: [RFC 3/5] pinctrl: exynos: add exynos5410 SoC specific data
In-Reply-To: <CACRpkdazZTUS50_mrXd+sNVAdf2m7meT1_LX5r6BKg3U-tC3Kw@mail.gmail.com>
References: <1406549892-5558-1-git-send-email-afaerber@suse.de>
 <1406549892-5558-4-git-send-email-afaerber@suse.de>
 <CACRpkdazZTUS50_mrXd+sNVAdf2m7meT1_LX5r6BKg3U-tC3Kw@mail.gmail.com>
Message-ID: <53E4CE93.9000504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus, Andreas,

On 08.08.2014 14:55, Linus Walleij wrote:
> On Mon, Jul 28, 2014 at 2:18 PM, Andreas F?rber <afaerber@suse.de> wrote:
> 
>> From: Hakjoo Kim <ruppi.kim@hardkernel.com>
>>
>> Add Samsung EXYNOS5410 SoC specific data to enable pinctrl
>> support for all platforms based on EXYNOS5410.
>>
>> Cc: Hakjoo Kim <ruppi.kim@hardkernel.com>
>> [AF: Rebased onto Exynos5260]
> 
> I'm waiting for Tomasz to review this before applying.

Thanks for the reminder. I'm currently on holidays and I'm not following
the lists too closely, so sorry if I happen to miss some patches.

In general the changes look good, although I can't verify whether the
data being added really match the hardware, as I don't have access to
detailed information about Exynos5410. Also I believe this patch needs
to be rebased onto current pinctrl tree as several (conflicting)
improvements to the pinctrl-samsung driver hit it before this patch was
posted.

Best regards,
Tomasz

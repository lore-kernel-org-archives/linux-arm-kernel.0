From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 28 Aug 2013 15:11:08 +0200
Subject: [Patch v2] pinctrl: Add s5pv210 support to pinctrl-exynos
In-Reply-To: <CACRpkdYiB5OG-YPRozwEurPHECDzZjQUs2s_E8gCdeqDPyr+WA@mail.gmail.com>
References: <1377608890-8528-1-git-send-email-m.krawczuk@partner.samsung.com>
 <CACRpkdYiB5OG-YPRozwEurPHECDzZjQUs2s_E8gCdeqDPyr+WA@mail.gmail.com>
Message-ID: <521DF6EC.6030206@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/2013 02:51 PM, Linus Walleij wrote:
> On Tue, Aug 27, 2013 at 3:08 PM, Mateusz Krawczuk
> <m.krawczuk@partner.samsung.com> wrote:
> 
>> This patch implements pinctrl support and adds device tree bindings
>> for s5pv210.
>>
>> Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
> 
> Oh this one does add bindings, sorry for previous comment.
> 
> I want an ACK from Kukjin or Sylwester for this since it's
> something new for S5P.

I'm happy to see this, it will allow us to clean up some common
S5P/Exynos drivers by removing non-dt support from them, once
S5PV210 is converted to DT.


Regards,
-- 
Sylwester Nawrocki
Samsung R&D Institute Poland

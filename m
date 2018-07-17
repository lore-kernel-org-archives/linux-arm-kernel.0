From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 17 Jul 2018 22:01:29 +0200
Subject: [PATCH 5/5] ARM: dts: exynos: add tmu aliases nodes
In-Reply-To: <CANAwSgSUv9aY6bhMxdnj9yGS8Ds7Bevy09+k=74CwVqiOX2+gA@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <1531822342-4293-5-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPc256dCWWWaoJBOB9NUc=CUYtqgfeKh=LBOoFAfh_T8Ng@mail.gmail.com>
 <CANAwSgSUv9aY6bhMxdnj9yGS8Ds7Bevy09+k=74CwVqiOX2+gA@mail.gmail.com>
Message-ID: <CAJKOXPfSs7rRN9z7oOOX-0O3cC=+jT=WVGvaQ3j+yL=MD_ifUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 July 2018 at 21:56, Anand Moon <linux.amoon@gmail.com> wrote:
> Hi
>
> On 17 July 2018 at 17:59, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>>> add tmuctrl aliases node for exynos542x
>>
>> Please use full sentence, starting with capital letter and ending with
>> a dot. Also please explain why you need tmuctrl aliases.
>>
>
> As per the [0] Documentation/devicetree/bindings/thermal/exynos-thermal.txt
>
> For multi-instance tmu each instance should have an alias correctly
> numbered in "aliases" node.

Ah, right. However except reading value of alias and storing it, the
driver does not use it later. Maybe this should be just removed.

Best regards,
Krzysztof

From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 28 Sep 2015 12:39:33 +0200
Subject: [PATCH] ARM: dts: exynos4412-trats2: remove regulator-compatible
 usage
In-Reply-To: <CANAwSgS4uyXYTPWJTkiZ2fQkwXNF+P7Ziuoy6o6jXyEmTw6Ovg@mail.gmail.com>
References: <1443188657-13501-1-git-send-email-javier@osg.samsung.com>
 <CANAwSgS4uyXYTPWJTkiZ2fQkwXNF+P7Ziuoy6o6jXyEmTw6Ovg@mail.gmail.com>
Message-ID: <560918E5.6090108@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Anand,

On 09/28/2015 12:10 PM, Anand Moon wrote:
> Hi Javier,
> 

[snip]

>>
>> -                       ldo10_reg: ldo10 {
>> -                               regulator-compatible = "LDO10";
> Missing the node name 'LDO10'
>> +                       ldo10_reg: DO10 {

Thanks for pointing out, I had to look twice to understand what you were
saying. Isn't that the LDO10 is missing but that was mistyped as "DO10".

I posted a v2 fixing it.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

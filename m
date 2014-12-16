From: ykk@rock-chips.com (Kuankuan.Yang)
Date: Tue, 16 Dec 2014 14:17:51 +0800
Subject: [PATCH 5/6] dt-bindings: Add documentation for Rockchip hdmi-audio
In-Reply-To: <20141215161827.GE11764@sirena.org.uk>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
 <1418612114-19692-1-git-send-email-ykk@rock-chips.com>
 <20141215104029.GE11285@n2100.arm.linux.org.uk>
 <20141215120205.GZ11764@sirena.org.uk> <548EDDC2.9050104@rock-chips.com>
 <20141215161827.GE11764@sirena.org.uk>
Message-ID: <548FCE8F.7090106@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


? 2014?12?16? 00:18, Mark Brown ??:
> On Mon, Dec 15, 2014 at 09:10:26PM +0800, Kuankuan.Yang wrote:
>> Hi Mark & Russell:
> Please don't top post, that way people have some context for what you're
> saying - look at how people normally format their mails on thelist.
>
>> In that way, dt will only need compatible for creating sound device. is it
>> ok  ?
>> sound {
>>      compatible = "rockchip,rk3288-hdmi-audio";
>>      status = "okay";
>> }
>> could you give me some advises.
> That'd be good, though the other question is if this can be made to use
> simple-card so we can avoid having a custom driver for this.
Hi Russell  & Mark:

hdmi-audio driver share irq with dw_hdmi driver,  for continuing 
AHBAUDDMA or for detecting hdmi insert.
So maybe it's hard to switch to simple-card way,  Russell what's your 
opinion ?

Best Regards.

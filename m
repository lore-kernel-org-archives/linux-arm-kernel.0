From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 22 Mar 2016 23:12:51 +0100
Subject: Who is going to merge it [Was: Re: [PATCH v14 0/17] Add Analogix Core
 Display Port Driver]
In-Reply-To: <56F19AC9.5060507@osg.samsung.com>
References: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
 <CAD=FV=XXESzA6n6MNEGH1Kbh7CeL8xWX8CifFLVf91+0JyFcJQ@mail.gmail.com>
 <56F19AC9.5060507@osg.samsung.com>
Message-ID: <1919945.Y1tg0YzXlm@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Dienstag, 22. M?rz 2016, 16:19:37 schrieb Javier Martinez Canillas:
> On 03/18/2016 07:53 PM, Doug Anderson wrote:
> > On Thu, Mar 17, 2016 at 11:41 PM, Caesar Wang <caesar.upstream@gmail.com> 
wrote:
> Same here, this is the second time I tested this series (first time was
> v6 on October 25 [2]) and I think that has been out there for too long.
> 
> > Tested-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

So we have 3 tests (Doug, Caesar and me) for the Rockchip side as well as 
Javier for the Exynos side based on the most recent drm state.

As said by a lot of people it would be cool to get this merged soon - 
hopefully directly after -rc1. The only remaining question is through which 
tree it should go.

I guess there are two basic options:
- Inki takes the series - we could see the Rockchip-Ack being implied but 
maybe Mark can provide an explicit one
- Mark takes the series with an Ack from Inki for the shared parts

Inki, Mark do you have a preference?


Thanks
Heiko

From: yong.shen@linaro.org (Yong Shen)
Date: Tue, 11 Jan 2011 15:54:43 +0800
Subject: [PATCH 0/2] ARM i.MX53 enable SMD and LOCO board bootup
In-Reply-To: <20110111072301.GA19168@jasper.tkos.co.il>
References: <1294726998-20830-1-git-send-email-yong.shen@freescale.com>
	<20110111072301.GA19168@jasper.tkos.co.il>
Message-ID: <AANLkTikhf7ReDZRt+CRuzupD_oQb7LMfTDa2fvpjayRB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

So far they are similar, but as more code and features are added in,
they are going to be different. We had registered different mach id to
distinguish these two boards.

Thanks
Yong

On Tue, Jan 11, 2011 at 3:23 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> Hi Yong,
>
> On Tue, Jan 11, 2011 at 02:23:16PM +0800, yong.shen at freescale.com wrote:
>> SMD and LOCO are newly developed boards of i.MX53. LOCO means "low cost",
>> which is supposed to be widespread soon.
>
> These two patches seem almost identical. Can't both board support code share
> the same file?
>
> baruch
>
> --
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ~. .~ ? Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
> ? - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
>

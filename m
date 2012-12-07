From: cjb@laptop.org (Chris Ball)
Date: Fri, 07 Dec 2012 13:56:45 -0500
Subject: [PATCH 0/3] mmc: add a card-event host call-back
In-Reply-To: <20121207134158.GA30468@S2100-06.ap.freescale.net> (Shawn Guo's
 message of "Fri, 7 Dec 2012 21:42:01 +0800")
References: <Pine.LNX.4.64.1212041633470.26918@axis700.grange>
 <20121207134158.GA30468@S2100-06.ap.freescale.net>
Message-ID: <87vccdbsia.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 07 2012, Shawn Guo wrote:
> On Tue, Dec 04, 2012 at 04:51:28PM +0100, Guennadi Liakhovetski wrote:
>> In a recent thread [1] an extension to the slot-gpio MMC API, adding a 
>> host call-back for card detection events, has been proposed. This 
>> extension shall be used by the SDHCI driver to reset the host if the card 
>> is ejected during a running request. These patches add such a call-back.
>> 
> For the series,
>
> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

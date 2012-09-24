From: stigge@antcom.de (Roland Stigge)
Date: Mon, 24 Sep 2012 10:04:07 +0200
Subject: [PATCH] video: Remove pnx4008 driver
In-Reply-To: <505F6436.3050009@gmx.de>
References: <1345991001-32462-1-git-send-email-stigge@antcom.de>
 <1345991001-32462-2-git-send-email-stigge@antcom.de>
 <505F6436.3050009@gmx.de>
Message-ID: <506013F7.20404@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 09/23/2012 09:34 PM, Florian Tobias Schandinat wrote:
> On 08/26/2012 02:23 PM, Roland Stigge wrote:
>> This patch removes the video driver for pnx4008. The architecture is being
>> removed via the arm-soc tree.
>>
>> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 
> Applied as it doesn't make sense to keep it around if there is no
> architecture left that can use it. Though I didn't get any technical
> reason why the architecture is removed at all, just reasons why it might
> be okay to do so. But it doesn't matter as I don't have to decide this
> anyway.

Right, there are no formal technical reasons, except that we are forward
porting this architecture+video driver for years now without any
indication that the changes were actually tested successfully. No known
current users, even in the development community. And it takes resources
developing the related architecture lpc32xx because of drivers shared
between the two.

Thanks,

Roland

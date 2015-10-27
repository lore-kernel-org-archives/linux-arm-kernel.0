From: jenskuske@gmail.com (Jens Kuske)
Date: Tue, 27 Oct 2015 17:54:32 +0100
Subject: [PATCH 4/6] reset: sunxi: Add compatible for Allwinner H3 bus
 resets
In-Reply-To: <20151022075835.GM10947@lukather>
References: <1445444428-4652-1-git-send-email-jenskuske@gmail.com>
 <20151022075835.GM10947@lukather>
Message-ID: <562FAC48.1070905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/10/15 09:58, Maxime Ripard wrote:
> On Wed, Oct 21, 2015 at 06:20:26PM +0200, Jens Kuske wrote:
>> Adding a new compatible allows us to define SoC specific behaviour
>> if necessary, for example forcing a particular device out of reset
>> even if no driver is actually using it.
>>
>> Signed-off-by: Jens Kuske <jenskuske@gmail.com>
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Thanks!
> Maxime
> 

Hi,

I've send a new version of this patch, please don't apply this version.

Jens

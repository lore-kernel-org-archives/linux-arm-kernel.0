From: jenskuske@gmail.com (Jens Kuske)
Date: Mon, 18 May 2015 11:55:05 +0200
Subject: [PATCH v2 08/10] reset: sunxi: Add compatible for Allwinner H3
 bus resets
In-Reply-To: <20150517143132.GI4004@lukather>
References: <1431707940-19372-1-git-send-email-jenskuske@gmail.com>
 <1431707940-19372-9-git-send-email-jenskuske@gmail.com>
 <20150517143132.GI4004@lukather>
Message-ID: <5559B6F9.8030403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/15 16:31, Maxime Ripard wrote:
> On Fri, May 15, 2015 at 06:38:58PM +0200, Jens Kuske wrote:
>> Adding a new compatible allows us to define SoC specific behaviour
>> if necessary, for example forcing a particular device out of reset
>> even if no driver is actually using it.
>>
>> Signed-off-by: Jens Kuske <jenskuske@gmail.com>
> 
> This should have been sent to the reset framework maintainer.

I knew I missed something. Given all the other comments, I'll need a v3
anyway.

Jens

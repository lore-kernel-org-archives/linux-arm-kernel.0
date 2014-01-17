From: klightspeed@killerwolves.net (Ben Peddell)
Date: Fri, 17 Jan 2014 22:45:02 +1000
Subject: [PATCH REPOST] ARM: Fix incorrect FDT initrd parameter override
In-Reply-To: <CAL_JsqJNPbQVKtW0amaOSc1is9oKrGapaHR=YJGJy6TrGQeKYw@mail.gmail.com>
References: <deeb5f$5527t1@icp-osb-irony-out2.iinet.net.au>
 <CAL_JsqJNPbQVKtW0amaOSc1is9oKrGapaHR=YJGJy6TrGQeKYw@mail.gmail.com>
Message-ID: <52D925CE.8050204@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 10:04 AM -0600, Rob Herring wrote:
>> Signed-off-by: Ben Peddell <klightspeed@killerwolves.net>
> 
> I'd really like to see phys_initrd_* removed, but that would be more
> invasive, so:
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> Please submit to Russell's patch system and mark for stable. I don't
> think there is time before 3.13 is released.

This patch (7941/2) was submitted on 14 Jan after being acked by Jason Cooper.

<http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/225272.html>

I apologise for the duplicate patch post.

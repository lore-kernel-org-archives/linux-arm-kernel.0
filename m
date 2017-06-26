From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 26 Jun 2017 23:35:34 +0200
Subject: [PATCH 2/2] rtc: brcmstb-waketimer: Add Broadcom STB wake-timer
In-Reply-To: <35c43786-ee58-130c-2ecd-5577197bd5aa@gmail.com>
References: <20170615195904.12653-1-f.fainelli@gmail.com>
 <20170615195904.12653-3-f.fainelli@gmail.com>
 <20170624185942.vq656pjxbqnqdhll@piout.net>
 <35c43786-ee58-130c-2ecd-5577197bd5aa@gmail.com>
Message-ID: <20170626213534.jur6rggwbzhk6r4t@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/06/2017 at 10:15:46 -0700, Florian Fainelli wrote:
> > This is not needed since d68778b80dd7
> 
> Great, I will take that out.
> 
> Do you care whether some dev_dbg() prints are left in the driver or
> should I remove those in v2?
> 

It could have stayed but it seems you removed it from v2.

I'll applay that but it is ok if you change your mind.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

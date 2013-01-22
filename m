From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 22 Jan 2013 09:00:03 +0800
Subject: [PATCH] ARM: plat-samsung: using vsnprintf instead of vsprintf
 for the limit buffer length 256
In-Reply-To: <20130121135626.GP1095@trinity.fluff.org>
References: <50FD178E.9090105@asianux.com>
 <20130121135626.GP1095@trinity.fluff.org>
Message-ID: <50FDE493.1020204@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?01?21? 21:56, Ben Dooks ??:
> How about: vsnprintf(buff, sizeof(buff), fmt, va);
> 
> It means we do not end up assuming the size of 'buff' and will be correct
> if the code is changed to declare 'buff' to be a different size.

  thank you, I will send patch v2.

  :-)

-- 
Chen Gang

Asianux Corporation

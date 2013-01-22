From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 22 Jan 2013 09:00:50 +0800
Subject: [PATCH] ARM: plat-samsung: using vsnprintf instead of vsprintf
 for the limit buffer length 256
In-Reply-To: <20130121160008.GO23505@n2100.arm.linux.org.uk>
References: <50FD178E.9090105@asianux.com>
 <20130121160008.GO23505@n2100.arm.linux.org.uk>
Message-ID: <50FDE4C2.1010208@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?01?22? 00:00, Russell King - ARM Linux ??:
> sizeof(buff) would be better here so that it depends on the actual buffer
> size.

  thank you, I will send patch v2.

  :-)

-- 
Chen Gang

Asianux Corporation

From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 15 Feb 2014 23:34:58 -0300
Subject: [PATCH v2 01/23] ARM: Kirkwood: Give pm.c its own header file.
In-Reply-To: <1392459621-24003-2-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <1392459621-24003-2-git-send-email-andrew@lunn.ch>
Message-ID: <20140216023457.GC8926@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 15, 2014 at 11:19:59AM +0100, Andrew Lunn wrote:
> The pm code needs to be seperated from common.h in order to split DT
> and non-DT systems apart. Move the declarations into a header file of
> its own and include it where needed.
> 

s/seperated/separated

Other than that:

Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

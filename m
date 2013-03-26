From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 26 Mar 2013 09:27:09 -0300
Subject: [PATCH 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <20130307175016.1dad1405@skate>
References: <1362660865-2755-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1362660865-2755-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130307175016.1dad1405@skate>
Message-ID: <20130326122708.GC2454@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Thu, Mar 07, 2013 at 05:50:16PM +0100, Thomas Petazzoni wrote:
[...]
> 
> Are you sure this is true? In your ->probe() function, you're creating
> address decoding windows, and instantiating devices. If mvebu-mbus is
> compiled as a module, we want all the child devices to disappear, no?
> 

Thanks for the review. I'll address all your comments in v2.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

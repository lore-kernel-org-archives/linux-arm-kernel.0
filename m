From: horms@verge.net.au (Simon Horman)
Date: Mon, 18 Nov 2013 17:59:55 +0900
Subject: [PATCH] ARM: shmobile: Use ->init_late() on Lager
In-Reply-To: <20131113223406.20634.52693.sendpatchset@w520>
References: <20131113223406.20634.52693.sendpatchset@w520>
Message-ID: <20131118085953.GF1506@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 07:34:06AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Hook in shmobile_init_late() on Lager. This enables some PM
> related things like CPUIdle and Suspend-to-RAM.
> 
> With this patch applied it is possible to use Suspend-to-RAM:
> # echo enabled > /sys/class/tty/ttySC6/power/wakeup
> # echo mem > /sys/power/state 
> (wake by sending a character on the serial console)
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I will queue this up.

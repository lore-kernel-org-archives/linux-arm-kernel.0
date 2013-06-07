From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 7 Jun 2013 18:56:20 +0200
Subject: [PATCH 01/14] bus: mvebu-mbus: Use pr_fmt
In-Reply-To: <1370623671-7748-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1370623671-7748-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130607185620.20780fd6@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Fri,  7 Jun 2013 13:47:38 -0300, Ezequiel Garcia wrote:
> In order to clean message printing, we replace pr_info with pr_fmt.
> This is purely cosmetic change, with the sole purpose of making
> the code a bit more readable.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

I believe this one could be applied regardless of what happens to the
rest of the patch series.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

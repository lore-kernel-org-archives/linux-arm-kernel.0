From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 27 Jan 2017 10:29:24 +0100
Subject: [PATCH] memory: atmel-ebi: Enable the SMC clock if specified
In-Reply-To: <1485509049-372-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1485509049-372-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170127092924.34f6hr5n2vmukxjx@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/01/2017 at 10:24:09 +0100, Boris Brezillon wrote:
> Newer versions of the SMC block requires the SMC clock to be enabled
> before the SMC logic can be used.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/memory/atmel-ebi.c | 51 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 14 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

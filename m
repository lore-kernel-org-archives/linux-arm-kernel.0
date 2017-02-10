From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 10 Feb 2017 16:04:03 +0100
Subject: [PATCH] Do not initialise statics to NULL
In-Reply-To: <20170209215749.2664-1-yhvh2000@gmail.com>
References: <20170209215749.2664-1-yhvh2000@gmail.com>
Message-ID: <20170210150403.GB10271@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 09:57:49PM +0000, William Stevenson wrote:
> This patch fixes a checkpatch.pl error in bcm2835.c
> 
> ERROR: do not initialise statics to NULL
> 
> Signed-off-by: William Stevenson <yhvh2000@gmail.com>

Does not apply to my tree :(

From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 16 Nov 2012 10:44:09 -0600
Subject: [RFC] fbdev: arm has __raw I/O accessors, use them in fb.h
In-Reply-To: <1353057364-21214-1-git-send-email-archit@ti.com>
References: <1353057364-21214-1-git-send-email-archit@ti.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206B2644F3F@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, November 16, 2012 2:16 AM, Archit Taneja wrote:
>
> This removes the sparse warnings on arm platforms:
>
> warning: cast removes address space of expression
>
> Signed-off-by: Archit Taneja <archit@ti.com>

I submitted the same patch around early March 2012. So FWIW:

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Regards,
Hartley

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Apr 2010 13:42:15 +0100
Subject: [PATCH 12/16] i.MX31 pcm037: remove duplicated #include
In-Reply-To: <1270727427-840-1-git-send-email-weiyi.huang@gmail.com>
References: <1270727427-840-1-git-send-email-weiyi.huang@gmail.com>
Message-ID: <20100408124215.GE31407@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 08, 2010 at 07:50:27PM +0800, Huang Weiyi wrote:
> Remove duplicated #include('s) in
>   arch/arm/mach-mx3/mach-pcm037.c
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

I suggest holding off on this; I merged Sascha's tree for -rc, and fixed
the resulting merge conflict which included deleting this line.

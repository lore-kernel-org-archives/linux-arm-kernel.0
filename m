From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 24 Aug 2011 15:44:46 +0100
Subject: [PATCH 1/2] ARM: L2X0: add explicit cpu_relax() for busy wait loop
In-Reply-To: <1314149411-5063-1-git-send-email-Baohua.Song@csr.com>
References: <1314149411-5063-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20110824144446.GN23757@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Barry,

On Tue, Aug 23, 2011 at 06:30:11PM -0700, Barry Song wrote:
> using cpu_relax in busy loops is a well-known idiom in the kernel. It's more
> for documentation purposes than technically needed here.
> 
> Cc: Jamie Iles <jamie@jamieiles.com>

Reviewed-by: Jamie Iles <jamie@jamieiles.com>

for both patches!

Jamie

From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 May 2018 19:43:55 +0530
Subject: [PATCH v9 05/27] ARM: davinci: da830: add new clock init using
 common clock framework
In-Reply-To: <20180427001745.4116-6-david@lechnology.com>
References: <20180427001745.4116-1-david@lechnology.com>
 <20180427001745.4116-6-david@lechnology.com>
Message-ID: <0e0aac5a-70b5-e90a-2ae4-7209003da922@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 April 2018 05:47 AM, David Lechner wrote:
> This adds the new board-specific clock init in mach-davinci/da830.c
> using the new common clock framework drivers.
> 
> The #ifdefs are needed to prevent compile errors until the entire
> ARCH_DAVINCI is converted.
> 
> Also clean up the #includes since we are adding some here.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar

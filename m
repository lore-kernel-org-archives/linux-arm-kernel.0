From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 28 Nov 2017 17:13:45 +0300
Subject: [PATCH] staging: fsl-mc: fix uninitialized variable use
In-Reply-To: <5A1BDB08.5070808@nxp.com>
References: <20171127090134.19125-1-laurentiu.tudor@nxp.com>
 <20171127090817.GA14195@kroah.com> <5A1BDB08.5070808@nxp.com>
Message-ID: <20171128141345.e2dxm2txmb73ed6k@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 09:31:21AM +0000, Laurentiu Tudor wrote:
> I did but it didn't show up on my version of powerpc toolchain (gcc 
> 4.8.1). Maybe it's too old ...
> 

Smatch has new uninitialized variable warnings these days.  In theory,
it should be smarter and more strict than GCC.

regards,
dan carpenter

From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Dec 2015 15:28:02 +0530
Subject: [PATCH v3] ARM: davinci: fix a problematic usage of WARN()
In-Reply-To: <fc8f1f2ff507111312243282dc462d00411eb4fe.1448497781.git.geliangtang@163.com>
References: <fc8f1f2ff507111312243282dc462d00411eb4fe.1448497781.git.geliangtang@163.com>
Message-ID: <566FE42A.6010104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 November 2015 06:05 AM, Geliang Tang wrote:
> WARN() takes a condition and a format string. The condition was
> omitted. So I added it.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Applied.

Thanks,
Sekhar

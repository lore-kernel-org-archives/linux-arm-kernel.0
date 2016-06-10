From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 10 Jun 2016 11:51:56 +0200
Subject: [RFC PATCH 03/15] clk: samsung: exynos4: fixup reg access on be
In-Reply-To: <20160608183110.13851-4-matthew@mattleach.net>
References: <20160608183110.13851-1-matthew@mattleach.net>
 <20160608183110.13851-4-matthew@mattleach.net>
Message-ID: <575A8DBC.4070403@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2016 08:30 PM, Matthew Leach wrote:
> Use the byte-order aware big endian accessors, allowing for kernels
> running under big-endian.
> 
> Signed-off-by: Matthew Leach <matthew@mattleach.net>

Patch applied, thanks.

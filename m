From: horms@verge.net.au (Simon Horman)
Date: Tue, 18 Feb 2014 08:48:45 +0900
Subject: [PATCH v2] ARM: shmobile: Remove KZM9D board code
In-Reply-To: <20140217072419.27232.82739.sendpatchset@w520>
References: <20140217072419.27232.82739.sendpatchset@w520>
Message-ID: <20140217234839.GA4776@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 04:24:19PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Get rid of KZM9D board code written in C. This version of the
> C board code was used in the case of multiplatform, but these
> days DT can be used instead, so because of that simply get rid
> of the C code to simplify and save space.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks Magnus, I have queued this up.

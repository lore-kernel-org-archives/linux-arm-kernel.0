From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 3 Nov 2009 17:37:01 +0000
Subject: [PATCH 5/9] S3C64XX: Set rate of crystal mux
In-Reply-To: <1257259332-7867-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1257259332-7867-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20091103173701.GJ23772@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2009 at 02:42:08PM +0000, Mark Brown wrote:
> The current code assumes that the external clock mux will be set to
> the crystal. Set this up explicitly within the clock API.

should be merged now.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

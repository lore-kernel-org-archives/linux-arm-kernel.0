From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 Oct 2013 12:54:39 +0900
Subject: [PATCH 00/02] ARM: shmobile: r8a7791 Koelsch DT reference
 support V2
In-Reply-To: <20131008063000.24789.7845.sendpatchset@w520>
References: <20131008063000.24789.7845.sendpatchset@w520>
Message-ID: <20131009035438.GQ15065@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 03:30:00PM +0900, Magnus Damm wrote:
> ARM: shmobile: r8a7791 Koelsch DT reference support V2
> 
> [PATCH 01/02] ARM: shmobile: r8a7791 Koelsch DT reference DTS bits
> [PATCH 02/02] ARM: shmobile: r8a7791 Koelsch DT reference C bits
> 
> This series is V2 of Koelsch DT reference support. At this point the
> board file is separated from the legacy Koelsch board support, and in
> the not so distant future this DT reference board file will be converted
> into MULTIPLATFORM only. This can only happen after r8a7791 CCF support
> has been added.
> 
> After CCF and MULTIPLATFORM are done for r8a7791 the board support code
> will be converted into same style as EMEV2, for more details please
> see the following series:
> 
> [PATCH 00/05] ARM: shmobile: KZM9D Multiplatform update
> 
> Changes since V1 are DT_MACHINE update to sync with legacy board
> code and patch splitting to simplify merge dependencies.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued these up.

From: horms@verge.net.au (Simon Horman)
Date: Fri, 8 Nov 2013 16:52:37 +0900
Subject: [PATCH 00/04] ARM: shmobile: KZM9D legacy board code removal
In-Reply-To: <20131106232102.8081.20523.sendpatchset@w520>
References: <20131106232102.8081.20523.sendpatchset@w520>
Message-ID: <20131108075235.GD23477@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 07, 2013 at 08:21:02AM +0900, Magnus Damm wrote:
> ARM: shmobile: KZM9D legacy board code removal
> 
> [PATCH 01/04] ARM: shmobile: Add shared EMEV2 code for ->init_machine()
> [PATCH 02/04] ARM: shmobile: Use ->init_late() in shared EMEV2 case
> [PATCH 03/04] ARM: shmobile: Remove legacy KZM9D board code
> [PATCH 04/04] ARM: shmobile: Remove legacy platform devices from EMEV2 SoC code 
> 
> With this patch set applied it is possible to use DT for KZM9D board support.
> Because of this is the KZM9D legacy C board code removed together with EMEV2
> platform devices. All these devices are available via DT anyway, so there is
> no need to keep the C version. This saves some lines of code and shows where
> mach-shmobile is heading in the future for all the SoCs.

Thanks, I have queued these up.

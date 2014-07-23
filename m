From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Jul 2014 22:23:38 +0200
Subject: [PATCH RESEND v2] bus: ARM CCN PMU driver
In-Reply-To: <1406050379-15199-1-git-send-email-pawel.moll@arm.com>
References: <1406050379-15199-1-git-send-email-pawel.moll@arm.com>
Message-ID: <201407232223.39341.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 July 2014, Pawel Moll wrote:
> Driver providing perf backend for ARM Cache Coherent Network
> interconnect. Supports counting all hardware events and crosspoint
> watchpoints.
> 
> Currently works with CCN-504 only, although there should be
> no changes required for CCN-508 (just impossible to test it now).
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Applied to next/drivers, thanks!

	Arnd

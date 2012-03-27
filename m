From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Mar 2012 08:40:39 +0100
Subject: [PATCH 2/2] ARM: lib: use LDRD/STRD for data copy
In-Reply-To: <00d501cd0bb0$724ab260$56e01720$%kim@samsung.com>
References: <007201cd059e$4af2cc10$e0d86430$%kim@samsung.com>
 <00d501cd0bb0$724ab260$56e01720$%kim@samsung.com>
Message-ID: <20120327074039.GJ5611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 09:27:52AM +0900, Boojin Kim wrote:
> This patch uses LDRD/STRD that loads and stores data as DWORD unit.
> It brings better performance than LDRM/STRM with cortex-a15.

Why should I bother looking at this rubbish?  You've been told before
that using ldrd and strd unconditionally is not acceptable.  Stop
wasting peoples review time.

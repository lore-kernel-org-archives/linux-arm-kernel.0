From: aletes.xgr@gmail.com (Alexandre Pereira da Silva)
Date: Mon, 11 Jun 2012 19:19:46 -0300
Subject: [PATCH 3/14] ARM: LPC32xx: Remove SLC controller initialization
 from platform init
In-Reply-To: <1339412537-24485-4-git-send-email-stigge@antcom.de>
References: <1339412537-24485-1-git-send-email-stigge@antcom.de>
 <1339412537-24485-4-git-send-email-stigge@antcom.de>
Message-ID: <CAAAP30F_kazyVP5GokpG-SGzFRxX7iLuo3eTmO8m9gN4hwDDXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 8:02 AM, Roland Stigge <stigge@antcom.de> wrote:
> Since we now support two MTD NAND controllers (MLC and SLC) for LPC32xx via DT,
> we don't initialize the SLC controller statically anymore, but do it via the
> clock setup (see previous patch).
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Tested-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

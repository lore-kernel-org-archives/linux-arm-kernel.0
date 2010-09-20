From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Sep 2010 19:59:27 +0100
Subject: Could it be a case of deadlock on SMP?
In-Reply-To: <AANLkTinNq6WVNT543QcG+1eVB9te1mmypD4pEvpFhqoJ@mail.gmail.com>
References: <AANLkTinNq6WVNT543QcG+1eVB9te1mmypD4pEvpFhqoJ@mail.gmail.com>
Message-ID: <20100920185927.GC5177@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 21, 2010 at 02:46:57AM +0800, Andrew Yan-Pai Chen wrote:
> We try to verify our dual-core processor (non v7) by LTP tests.

Is this a non-ARM SMP implementation then?

If this is an ARM SMP implementation, then please provide the
CPU model, revision and variant information.

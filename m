From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 28 Mar 2014 10:49:23 +0000
Subject: disabling MMU of ARMv7-A
In-Reply-To: <CAO1A-8DB_xAqAb2DOED3fmQ0GEOP4FFNyuZTVnjX+kiv4sRrtA@mail.gmail.com>
References: <015e01cf4a55$7f43a950$7dcafbf0$@samsung.com>
 <CAO1A-8DB_xAqAb2DOED3fmQ0GEOP4FFNyuZTVnjX+kiv4sRrtA@mail.gmail.com>
Message-ID: <20140328104923.GH21330@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 07:23:45AM +0000, Marc C wrote:
> > However, ARMv7-A/R doesn't have such register. They can only control whether
> > use _HIGH_ vector or no
> 
> Not entirely accurate. ARMv7-A, and the Cortex-A9, specify the Vector
> Base Address
> Register, or VBAR [1].

Good point, I missed this. It only works if SCTLR.V is 0 (so low
vectors).

-- 
Catalin

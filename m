From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 07 Jan 2011 01:33:32 +0000
Subject: [PATCH 0/2] Common struct clk implementation, v10
In-Reply-To: <1294199462.347935.472473715866.0.gpush@pororo>
References: <1294199462.347935.472473715866.0.gpush@pororo>
Message-ID: <4D266D6C.7050005@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/11 03:51, Jeremy Kerr wrote:
> Hi all,
> 
> These patches are an attempt to allow platforms to share clock code. At
> present, the definitions of 'struct clk' are local to platform code,
> which makes allocating and initialising cross-platform clock sources
> difficult, and makes it impossible to compile a single image containing
> support for two ARM platforms with different struct clks.

no, it doesn't actually. you could do run-time link and select
the right arch support.

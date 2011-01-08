From: ben-linux@fluff.org (Ben Dooks)
Date: Sat, 08 Jan 2011 17:42:05 +0000
Subject: [PATCH 1/6] i2c-pxa: move i2c_pxa_remove to __devexit instead
	of just	__exit
In-Reply-To: <1294193110-23958-1-git-send-email-dbaryshkov@gmail.com>
References: <1294193110-23958-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <4D28A1ED.90803@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/11 02:05, Dmitry Eremin-Solenikov wrote:
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: linux-i2c at vger.kernel.org
> Cc: Ben Dooks <ben-linux@fluff.org>
> ---

this should be queued, and probably sent to Linus
at the end of the weekend.

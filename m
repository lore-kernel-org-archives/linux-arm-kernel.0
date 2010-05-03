From: jason.mcmullan@netronome.com (Jason McMullan)
Date: Mon, 3 May 2010 12:48:00 -0400
Subject: Add support for the 16-way L310 L2 cache controller
In-Reply-To: <-5319252541413655868@unknownmsgid>
References: <-5319252541413655868@unknownmsgid>
Message-ID: <p2hd91d07041005030948j7882d74dx4614fc207e6266aa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 29, 2010 at 12:20 PM, Will Deacon <will.deacon@arm.com> wrote:
> The patch entitled `Add support for the 16-way L310 L2 cache controller'
> which you submitted to RMK's patch system appears to perform a 16-way
> invalidation even when the ways might not be present. This results in
> writes to the reserved bits [15:8] of the invalidate-by-way ctrl register.
>
> You can check the associativity by reading bit 16 of the auxiliary ctrl
> register.

This issue was addressed in the patches I submitted to the l-a-k list on
Friday.

Please review those, and I will re-submit to the patch queue if they meet
your approval.

--
Jason McMullan

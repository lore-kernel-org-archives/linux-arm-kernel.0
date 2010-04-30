From: jason.mcmullan@netronome.com (Jason McMullan)
Date: Fri, 30 Apr 2010 13:17:39 -0400
Subject: Add support for the 16-way L310 L2 cache controller
In-Reply-To: <3756028016583358140@unknownmsgid>
References: <3756028016583358140@unknownmsgid>
Message-ID: <k2nd91d07041004301017s5663c595o62c22c2d47ce1153@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 29, 2010 at 12:20 PM, Will Deacon <will.deacon@arm.com> wrote:
> The patch entitled `Add support for the 16-way L310 L2 cache controller'
> which you submitted to RMK's patch system appears to perform a 16-way
> invalidation even when the ways might not be present. This results in
> writes to the reserved bits [15:8] of the invalidate-by-way ctrl register.

Good catch Will. I'll update it, and sent it to the list.

--
Jason S. McMullan
jaosn.mcmullan at netronome.com

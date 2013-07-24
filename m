From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Jul 2013 15:44:20 +0100
Subject: [PATCH 05/14] ARM: pl01x debug code endian fix
In-Reply-To: <1374661682-9349-6-git-send-email-ben.dooks@codethink.co.uk>
References: <1374661682-9349-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374661682-9349-6-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130724144420.GN11072@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 11:27:53AM +0100, Ben Dooks wrote:
> The PL01X debug code needs to take into account which endian mode the
> processor is running in. If it is big-endian, ensure the data is swapped
> appropriately.
> 
> Note, we could do this slightly more efficiently if we have an macro to
> do the necessary swap for the bits used by test.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will

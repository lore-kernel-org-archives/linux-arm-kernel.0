From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 20 Jul 2010 11:22:06 +0200
Subject: Fwd: [RFC,PATCH 3/3] arm: remove machine_desc.io_pg_offst and
	.phys_io
In-Reply-To: <AANLkTilsIR36GNlbpZHt3FB5Dp2msedtUMFRSlZ-N-w9@mail.gmail.com>
References: <1279073377.400469.233833413341.0.gpush@pororo>
	<1279073377.404006.432977736300.3.gpush@pororo>
	<AANLkTilsIR36GNlbpZHt3FB5Dp2msedtUMFRSlZ-N-w9@mail.gmail.com>
Message-ID: <AANLkTilpIedM36r2fUuImyIVAVpfJse-vV1c_8cgwalH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 14, 2010 at 4:09 AM, Jeremy Kerr <jeremy.kerr@canonical.com> wrote:
> Since we're now using addruart to establish the debug mapping, we can
> remove the io_pg_offst and phys_io members of struct machine_desc.
>
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

Like this very much,

Acked-by: Eric Miao <eric.miao@canonical.com>

Russell,

I think it can be merged soon, need to rebase my 'machine_class' patches
on top of your -devel branch then.

(PS: forgot to remove the remaining content, which leaded the previous
message to be too long to pass the moderation :-/ )

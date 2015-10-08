From: horms@verge.net.au (Simon Horman)
Date: Thu, 8 Oct 2015 11:13:22 +0900
Subject: [PATCH] ARM: shmobile: porter: add SDHI0/2 DT support
In-Reply-To: <561573D8.6060203@cogentembedded.com>
References: <2228837.DO5U5OvRSi@wasted.cogentembedded.com>
 <20151007033957.GA30650@verge.net.au>
 <561573D8.6060203@cogentembedded.com>
Message-ID: <20151008021322.GE8756@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 10:34:48PM +0300, Sergei Shtylyov wrote:
> On 10/07/2015 06:39 AM, Simon Horman wrote:
> 
> >>Define the Porter board dependent part of the SDHI0/2 device nodes along with
> >>the  necessary  voltage regulators (note that the Vcc regulators are dummy --
> >>they are required but don't actually exist on the board). Also, GPIOs have to
> >>be used for the CD and WP signals due to the SDHI driver constraints...
> >>
> >>This patch is analogous to the commit 1299df03d719 (ARM: shmobile: henninger:
> >>add SDHI0/2 DT support) as there  are no differences between those boards in
> >>this respect.
> >>
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>
> >>---
> >>This patch is against the 'renesas-devel-20151006-v4.3-rc4' tag of Simon
> >>Horman's 'renesas.git' repo.
> >
> >Thanks I have queued this up after addressing some issues
> >in the changelog that checkpatch complained about:
> 
> >* text > 75 characters wide
> >* Missing '"' around name of patch referred to
> 
>    Sorry about that, forgot to run thru checkpatch.pl (as usual :-).

No harm done.

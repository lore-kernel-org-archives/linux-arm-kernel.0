From: leoli@freescale.com (Li Yang)
Date: Fri, 4 Sep 2015 15:01:55 -0500
Subject: [PATCH v2 06/10] clk: qoriq: Add ls2080a support.
In-Reply-To: <1441349872-4560-7-git-send-email-bhupesh.sharma@freescale.com>
References: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
 <1441349872-4560-7-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <CADRPPNQsemXa2HgYZAcm+GurhimHbYVM5CL5ReDsyuzfAO=kSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 4, 2015 at 1:57 AM, Bhupesh Sharma
<bhupesh.sharma@freescale.com> wrote:
> From: Scott Wood <scottwood@freescale.com>
>
> LS2080A is the first implementation of the chassis 3 clockgen, which
> has a different register layout than previous chips.  It is also little
> endian, unlike previous chips.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---

You should probably mention here that the patch is depending on
another pending patch to apply.  And this patch should be going
through the same sub-system tree as the dependency patch.  Otherwise,
there is no way it can be applied.

Regards,
Leo

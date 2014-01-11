From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 11 Jan 2014 11:28:43 +0100
Subject: Add .determine_rate to composite clk
In-Reply-To: <CAJiWf8W6rCnnF9Tv+cpcqqshEb4ALD+J_RnYeLkaNVG-Rcd+QA@mail.gmail.com>
References: <CAJiWf8W6rCnnF9Tv+cpcqqshEb4ALD+J_RnYeLkaNVG-Rcd+QA@mail.gmail.com>
Message-ID: <20140111102843.GU2941@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lemon,

On Sat, Jan 11, 2014 at 05:15:58PM +0800, Lemon Dai wrote:
> Hi Mike,
> 
> As .determine_rate was added to struct clk and clk_mux_ops, maybe we
> should also copy determine_rate operation from mux_ops to
> clk_composite_ops in clk_register_composite( ),
> to make composite clk implementation more generic.

A similar patch is on its way to 3.14 already (commit 107f3198 in
Mike's clk-next branch).

Also, for future contributions, I'd suggest to read the
Documentation/SubmittingPatches file. Your patch had several style
issues that are covered in this file.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140111/9c6994f3/attachment.sig>

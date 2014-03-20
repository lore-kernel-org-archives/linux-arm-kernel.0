From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Mar 2014 10:47:17 +0100
Subject: [PATCH v7 1/8] clk: sunxi: factors: automatic reparenting support
In-Reply-To: <20140319233945.21989.12073@quantum>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch>
 <20140217100215.15040.63745.stgit@pagira.o2s.ch>
 <20140218140516.GG3142@lukather>
 <20140319233945.21989.12073@quantum>
Message-ID: <20140320094717.GL27873@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 04:39:45PM -0700, Mike Turquette wrote:
> Quoting Maxime Ripard (2014-02-18 06:05:16)
> > On Mon, Feb 17, 2014 at 11:02:15AM +0100, David Lanzend?rfer wrote:
> > > From: Emilio L?pez <emilio@elopez.com.ar>
> > > 
> > > This commit implements .determine_rate, so that our factor clocks can be
> > > reparented when needed.
> > > 
> > > Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> > 
> > Your signed-off-by is missing here.
> > 
> > Once you added it, you can add my Acked-by
> 
> Yes the patch looks good to me as well. Am I correct in thinking that it
> is independent of the MMC clock phase discussion? If it is resubmitted
> with a proper SoB then I can pick it.

Yes, it's completely independant of the MMC phase stuff.

Emilio, or David, could you resend it?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140320/2de77768/attachment.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Feb 2014 15:05:16 +0100
Subject: [PATCH v7 1/8] clk: sunxi: factors: automatic reparenting support
In-Reply-To: <20140217100215.15040.63745.stgit@pagira.o2s.ch>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch>
 <20140217100215.15040.63745.stgit@pagira.o2s.ch>
Message-ID: <20140218140516.GG3142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 11:02:15AM +0100, David Lanzend?rfer wrote:
> From: Emilio L?pez <emilio@elopez.com.ar>
> 
> This commit implements .determine_rate, so that our factor clocks can be
> reparented when needed.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

Your signed-off-by is missing here.

Once you added it, you can add my Acked-by

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140218/054fe3c9/attachment-0001.sig>

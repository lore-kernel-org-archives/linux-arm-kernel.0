From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 21 Jan 2011 19:57:55 +0000
Subject: [stable] [PATCH] ARM: SMDK6410: Fix build with WM1190 disabled
	and WM1192 enabled
In-Reply-To: <20110121195418.GA18700@kroah.com>
References: <1295630829-13812-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110121191507.GA16210@kroah.com>
	<20110121194656.GB3075@sirena.org.uk>
	<20110121195418.GA18700@kroah.com>
Message-ID: <20110121195754.GA27353@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 11:54:18AM -0800, Greg KH wrote:
> On Fri, Jan 21, 2011 at 07:46:56PM +0000, Mark Brown wrote:

> > I believe the build breakage affects existing released kernels with the
> > appropriate set of configuration options chosen (1192 enabled and 1190
> > disabled), yes.  This is a pretty obscure combination so it's unlikely
> > anyone will run into it in practice.

> Ok, then it probably shouldn't be a -stable patch :)

Oh, OK.  It seemed like it was sufficiently safe to make the risk/value
for the change reasonable.

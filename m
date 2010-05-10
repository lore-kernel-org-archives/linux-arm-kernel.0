From: felipe.balbi@nokia.com (Felipe Balbi)
Date: Mon, 10 May 2010 21:15:07 +0300
Subject: [PATCHv4 1/4] procfs: Introduce socinfo under /proc
In-Reply-To: <20100510130809.GC11804@besouro.research.nokia.com>
References: <1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com>
	<1273487857-32281-3-git-send-email-eduardo.valentin@nokia.com>
	<1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com>
	<1273487857-32281-2-git-send-email-eduardo.valentin@nokia.com>
	<20100510111259.GA14680@linux-sh.org>
	<20100510125440.GA31721@nokia.com>
	<20100510130809.GC11804@besouro.research.nokia.com>
Message-ID: <20100510181507.GA32540@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 10, 2010 at 03:08:09PM +0200, Valentin Eduardo (Nokia-D/Helsinki) wrote:
>I'm not aware of the module parameter stuff.. but the leak might be other thing
>than kstrdup?

yeah, I was following the code and the problem is how the kernel handles 
charp module parameters

-- 
balbi

DefectiveByDesign.org
